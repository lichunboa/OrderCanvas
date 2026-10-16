// SPDX-License-Identifier: MIT
#ifndef TV_TRADE_ANALYTICS_MQH
#define TV_TRADE_ANALYTICS_MQH
// Pure trade-data domain. No terminal, chart, object, history or trading calls.
// side: +1 buy / -1 sell. entry: 0 IN / 1 OUT / 2 INOUT / 3 OUT_BY.
struct TVTradeDeal
{
   ulong ticket,position;
   string symbol;
   int side,entry;
   datetime time;
   double volume,price,profit,commission,swap,fee;
   double risk;   // entry fills: account money lost if the stop recorded on the deal is hit; 0 = no stop
   long msc;      // deal time in milliseconds (tick-range lookups); 0 = unknown
};
struct TVClosedTrade
{
   ulong position;
   string symbol;
   int side;
   double volume,entryPrice,exitPrice,gross,commission,swap,fee,net;
   datetime openTime,closeTime;
   ulong closeTicket;
   double risk;        // initial risk at the stop (sum of the entry fills); 0 = unknown / no stop
   bool riskMissing;   // an entry fill had no stop: the trade's risk is unknown
   long openMsc,closeMsc;
   double mae;         // largest floating loss while open (money, >= 0); < 0 = not known yet
};
struct TVTradeStats
{
   double net,grossProfit,grossLoss;
   int trades,wins;
   double winRate,avgWin,avgLoss,ratio,largestWin,largestLoss;
   int maxWins,maxLosses;
   double avgSeconds;
};
struct TVTradeBucket
{
   string symbol;
   int trades,wins;
   double net,winRate;
};
struct TVTradeAnalytics
{
   TVTradeStats all,longs,shorts;
   double startingBalance,netPercent,profitFactor,maxDrawdown,maxDrawdownPercent;
   double expectancy,recovery,sharpe,adverseRun,costs;
   // Costs by kind (charges negative) and the risk actually taken: initial stop risk
   // per trade, which is not the drawdown (the equity curve's fall from a peak).
   double commission,swap,fee,risked,avgRisk,maxRisk,avgR,bestR,worstR;
   int riskTrades,noStopTrades;
   // Actual risk = MAE: how far each trade went against the position before it closed
   // (losers included). maeStopUse = average MAE / planned stop risk.
   double avgMae,maxMae,maeStopUse;int maeTrades,maeStopTrades;
   TVTradeBucket symbols[];
   TVTradeBucket weekdays[7];
   TVTradeBucket hours[24];
   TVTradeBucket holding[5];
   double equity[];
   double drawdown[];
   datetime times[];
};
bool TVDealBefore(const TVTradeDeal &a,const TVTradeDeal &b)
{
   if(a.position!=b.position) return a.position<b.position;
   if(a.time!=b.time) return a.time<b.time;
   return a.ticket<b.ticket;
}
bool TVTradeBefore(const TVClosedTrade &a,const TVClosedTrade &b)
{
   if(a.closeTime!=b.closeTime) return a.closeTime<b.closeTime;
   if(a.closeTicket!=b.closeTicket) return a.closeTicket<b.closeTicket;
   if(a.openTime!=b.openTime) return a.openTime<b.openTime;
   return a.position<b.position;
}
// Iterative mergesort avoids terminal-specific ArraySort rules and recursion.
void TVSortTradeDeals(TVTradeDeal &deals[])
{
   int n=ArraySize(deals);
   TVTradeDeal temp[];
   ArrayResize(temp,n);
   for(int width=1;width<n;width*=2)
   {
      for(int left=0;left<n;left+=2*width)
      {
         int mid=MathMin(left+width,n),right=MathMin(left+2*width,n);
         int a=left,b=mid;
         for(int j=left;j<right;j++)
         {
            if(a<mid && (b>=right || !TVDealBefore(deals[b],deals[a]))) temp[j]=deals[a++];
            else temp[j]=deals[b++];
         }
      }
      for(int j=0;j<n;j++) deals[j]=temp[j];
   }
}
void TVSortClosedTrades(TVClosedTrade &trades[])
{
   int n=ArraySize(trades);
   TVClosedTrade temp[];
   ArrayResize(temp,n);
   for(int width=1;width<n;width*=2)
   {
      for(int left=0;left<n;left+=2*width)
      {
         int mid=MathMin(left+width,n),right=MathMin(left+2*width,n);
         int a=left,b=mid;
         for(int j=left;j<right;j++)
         {
            if(a<mid && (b>=right || !TVTradeBefore(trades[b],trades[a]))) temp[j]=trades[a++];
            else temp[j]=trades[b++];
         }
      }
      for(int j=0;j<n;j++) trades[j]=temp[j];
   }
}
void TVResetClosedTrade(TVClosedTrade &t)
{
   t.position=0;t.symbol="";t.side=0;t.volume=0;t.entryPrice=0;t.exitPrice=0;
   t.gross=0;t.commission=0;t.swap=0;t.fee=0;t.net=0;t.openTime=0;t.closeTime=0;t.closeTicket=0;
   t.risk=0;t.riskMissing=false;t.openMsc=0;t.closeMsc=0;t.mae=-1;
}
// One output per complete flat-to-flat episode. Position IDs survive netting
// reversals, so INOUT closes the old episode and starts a separate new side.
// Volume means total closed quantity; prices weight all fills, including scale-in.
// Missing entry history and episodes still open are deliberately excluded.
int TVAggregateTrades(TVTradeDeal &deals[],TVClosedTrade &trades[])
{
   TVSortTradeDeals(deals);
   int n=ArraySize(deals),count=0;
   ArrayResize(trades,n);
   int begin=0;
   while(begin<n)
   {
      int end=begin+1;
      while(end<n && deals[end].position==deals[begin].position) end++;
      TVClosedTrade current;
      TVResetClosedTrade(current);
      double remaining=0,entryValue=0,exitValue=0;
      bool incomplete=false;
      ulong lastTicket=0;
      for(int i=begin;i<end;i++)
      {
         TVTradeDeal d=deals[i];
         if(d.ticket!=0 && d.ticket==lastTicket) continue;
         lastTicket=d.ticket;
         if(d.position==0 || d.volume<=0 || (d.side!=1 && d.side!=-1)) continue;
         if(d.entry<0 || d.entry>3) continue;
         if(incomplete) continue;
         double eps=1e-9*MathMax(1.0,MathMax(remaining,d.volume));
         if(d.entry==0)
         {
            if(remaining<=eps)
            {
               TVResetClosedTrade(current);current.position=d.position;current.symbol=d.symbol;
               current.side=d.side;current.openTime=d.time;current.openMsc=d.msc;entryValue=0;exitValue=0;
            }
            else if(current.side!=d.side || current.symbol!=d.symbol)
            {
               incomplete=true;continue;
            }
            remaining+=d.volume;current.volume+=d.volume;entryValue+=d.volume*d.price;
            if(d.risk>0) current.risk+=d.risk;else current.riskMissing=true;
            current.gross+=d.profit;current.commission+=d.commission;current.swap+=d.swap;current.fee+=d.fee;
            continue;
         }
         if(remaining<=eps || current.side==d.side || current.symbol!=d.symbol)
         {
            incomplete=true;continue;
         }
         if(d.entry!=2 && d.volume>remaining+eps)
         {
            incomplete=true;continue;
         }
         double closing=MathMin(d.volume,remaining);
         double opening=(d.entry==2 ? MathMax(0.0,d.volume-closing) : 0.0);
         double fraction=(opening>eps ? closing/d.volume : 1.0);
         exitValue+=closing*d.price;current.gross+=d.profit;current.swap+=d.swap;
         current.commission+=d.commission*fraction;current.fee+=d.fee*fraction;
         remaining-=closing;
         if(remaining<=eps)
         {
            current.entryPrice=entryValue/current.volume;current.exitPrice=exitValue/current.volume;
            current.closeTime=d.time;current.closeMsc=d.msc;current.closeTicket=d.ticket;current.net=current.gross+current.commission+current.swap+current.fee;
            if(current.riskMissing) current.risk=0;
            trades[count++]=current;remaining=0;
            TVResetClosedTrade(current);entryValue=0;exitValue=0;
         }
         if(opening>eps)
         {
            current.position=d.position;current.symbol=d.symbol;current.side=d.side;current.openTime=d.time;current.openMsc=d.msc;
            current.volume=opening;remaining=opening;entryValue=opening*d.price;
            current.commission=d.commission*(1.0-fraction);current.fee=d.fee*(1.0-fraction);
            current.risk=0;current.riskMissing=true; // a reversal's new side has no recorded stop
         }
      }
      begin=end;
   }
   ArrayResize(trades,count);
   TVSortClosedTrades(trades);
   return count;
}
// Input must already be sorted by TVAggregateTrades/TVSortTradeDeals.
// Remaining opening commission follows proportional average-cost allocation:
// partial exits release their share; reversals retain only new-side entry cost.
double TVEntryCommission(const TVTradeDeal &deals[],const ulong position)
{
   int low=0,high=ArraySize(deals);
   while(low<high){int mid=(low+high)/2;if(deals[mid].position<position) low=mid+1;else high=mid;}
   double volume=0,cost=0;
   int side=0;
   ulong lastTicket=0;
   for(int i=low;i<ArraySize(deals) && deals[i].position==position;i++)
   {
      TVTradeDeal d=deals[i];
      if(d.ticket!=0 && d.ticket==lastTicket) continue;
      lastTicket=d.ticket;
      if(d.volume<=0 || (d.side!=1 && d.side!=-1)) continue;
      if(d.entry==0)
      {
         if(volume>1e-9 && side!=d.side) return 0;
         side=d.side;volume+=d.volume;cost+=d.commission;
      }
      else if(d.entry>=1 && d.entry<=3)
      {
         if(volume<=1e-9 || side==d.side) return 0;
         double closing=MathMin(volume,d.volume);
         cost*=MathMax(0.0,1.0-closing/volume);volume-=closing;
         if(d.entry==2 && d.volume>closing+1e-9)
         {
            volume=d.volume-closing;side=d.side;cost=d.commission*(volume/d.volume);
         }
      }
   }
   return (volume>1e-9 ? cost : 0.0);
}
void TVResetTradeStats(TVTradeStats &s)
{
   s.net=0;s.grossProfit=0;s.grossLoss=0;s.trades=0;s.wins=0;s.winRate=0;
   s.avgWin=0;s.avgLoss=0;s.ratio=0;s.largestWin=0;s.largestLoss=0;
   s.maxWins=0;s.maxLosses=0;s.avgSeconds=0;
}
void TVAddTradeStats(TVTradeStats &s,const TVClosedTrade &t,int &winRun,int &lossRun)
{
   s.trades++;s.net+=t.net;s.avgSeconds+=(double)MathMax((datetime)0,t.closeTime-t.openTime);
   if(t.net>0)
   {
      s.wins++;s.grossProfit+=t.net;s.largestWin=MathMax(s.largestWin,t.net);
      winRun++;lossRun=0;s.maxWins=MathMax(s.maxWins,winRun);
   }
   else if(t.net<0)
   {
      s.grossLoss-=t.net;s.largestLoss=MathMax(s.largestLoss,-t.net);
      lossRun++;winRun=0;s.maxLosses=MathMax(s.maxLosses,lossRun);
   }
   else {winRun=0;lossRun=0;}
}
void TVFinishTradeStats(TVTradeStats &s,const int losses)
{
   if(s.trades>0){s.winRate=100.0*s.wins/s.trades;s.avgSeconds/=s.trades;}
   if(s.wins>0) s.avgWin=s.grossProfit/s.wins;
   if(losses>0) s.avgLoss=s.grossLoss/losses;
   if(s.avgLoss>0) s.ratio=s.avgWin/s.avgLoss;
}
void TVResetTradeBucket(TVTradeBucket &b)
{
   b.symbol="";b.trades=0;b.wins=0;b.net=0;b.winRate=0;
}
void TVAddTradeBucket(TVTradeBucket &b,const TVClosedTrade &t)
{
   b.trades++;if(t.net>0) b.wins++;b.net+=t.net;
   b.winRate=100.0*b.wins/b.trades;
}
int TVHoldingBucket(const datetime seconds)
{
   if(seconds<300) return 0;
   if(seconds<3600) return 1;
   if(seconds<14400) return 2;
   if(seconds<86400) return 3;
   return 4;
}
void TVTradeSymbolOrder(const TVClosedTrade &trades[],int &order[])
{
   int n=ArraySize(trades);
   ArrayResize(order,n);
   int temp[];
   ArrayResize(temp,n);
   for(int i=0;i<n;i++) order[i]=i;
   for(int width=1;width<n;width*=2)
   {
      for(int left=0;left<n;left+=2*width)
      {
         int mid=MathMin(left+width,n),right=MathMin(left+2*width,n),a=left,b=mid;
         for(int j=left;j<right;j++)
         {
            if(a<mid && (b>=right || StringCompare(trades[order[a]].symbol,trades[order[b]].symbol)<=0)) temp[j]=order[a++];
            else temp[j]=order[b++];
         }
      }
      for(int j=0;j<n;j++) order[j]=temp[j];
   }
}
// P&L classification, profit factor and win/loss metrics use NET after all
// commission/swap/fee. Breakeven trades count in the win-rate denominator and
// reset runs. Percent DD is from the peak (starting balance + cumulative net).
// Sharpe-like ratio is mean/sample-SD of net/equity-before-trade, NONANNUALISED;
// returns with nonpositive pre-trade equity are excluded. No risk-free rate.
// costs = -(commission + swap): positive paid, negative credit. Fees remain in
// net. adverseRun is maximum sum of consecutive strictly negative net trades.
void TVComputeAnalytics(TVClosedTrade &trades[],const double startingBalance,TVTradeAnalytics &out)
{
   TVSortClosedTrades(trades);
   TVResetTradeStats(out.all);TVResetTradeStats(out.longs);TVResetTradeStats(out.shorts);
   out.startingBalance=startingBalance;out.netPercent=0;out.profitFactor=0;
   out.maxDrawdown=0;out.maxDrawdownPercent=0;out.expectancy=0;out.recovery=0;
   out.sharpe=0;out.adverseRun=0;out.costs=0;
   out.commission=0;out.swap=0;out.fee=0;out.risked=0;out.avgRisk=0;out.maxRisk=0;out.avgR=0;out.bestR=0;out.worstR=0;
   out.riskTrades=0;out.noStopTrades=0;out.avgMae=0;out.maxMae=0;out.maeStopUse=0;out.maeTrades=0;out.maeStopTrades=0;
   ArrayResize(out.symbols,0);
   for(int i=0;i<7;i++) TVResetTradeBucket(out.weekdays[i]);
   for(int i=0;i<24;i++) TVResetTradeBucket(out.hours[i]);
   for(int i=0;i<5;i++) TVResetTradeBucket(out.holding[i]);
   int n=ArraySize(trades);
   ArrayResize(out.equity,n);ArrayResize(out.drawdown,n);ArrayResize(out.times,n);
   int aw=0,al=0,lw=0,ll=0,sw=0,sl=0,losses=0,longLosses=0,shortLosses=0,returns=0;
   double cumulative=0,peak=startingBalance,adverse=0,returnMean=0,returnM2=0;
   for(int i=0;i<n;i++)
   {
      TVClosedTrade t=trades[i];
      TVAddTradeStats(out.all,t,aw,al);
      if(t.net<0) losses++;
      if(t.side==1){TVAddTradeStats(out.longs,t,lw,ll);if(t.net<0) longLosses++;}
      else if(t.side==-1){TVAddTradeStats(out.shorts,t,sw,sl);if(t.net<0) shortLosses++;}
      double before=startingBalance+cumulative;
      if(startingBalance>0 && before>0)
      {
         double value=t.net/before;
         returns++;double delta=value-returnMean;returnMean+=delta/returns;
         returnM2+=delta*(value-returnMean);
      }
      cumulative+=t.net;
      double balance=startingBalance+cumulative;
      peak=MathMax(peak,balance);
      double dd=MathMax(0.0,peak-balance);
      out.maxDrawdown=MathMax(out.maxDrawdown,dd);
      if(startingBalance>0 && peak>0) out.maxDrawdownPercent=MathMax(out.maxDrawdownPercent,100.0*dd/peak);
      out.equity[i]=cumulative;out.drawdown[i]=dd;out.times[i]=t.closeTime;
      if(t.net<0) adverse-=t.net;else adverse=0;
      out.adverseRun=MathMax(out.adverseRun,adverse);
      out.costs-=t.commission+t.swap;
      out.commission+=t.commission;out.swap+=t.swap;out.fee+=t.fee;
      if(t.risk>0)
      {
         const double r=t.net/t.risk;
         if(out.riskTrades==0){out.bestR=r;out.worstR=r;}else{out.bestR=MathMax(out.bestR,r);out.worstR=MathMin(out.worstR,r);}
         out.riskTrades++;out.risked+=t.risk;out.maxRisk=MathMax(out.maxRisk,t.risk);out.avgR+=r;
      }
      else out.noStopTrades++;
      if(t.mae>=0)
      {
         out.maeTrades++;out.avgMae+=t.mae;out.maxMae=MathMax(out.maxMae,t.mae);
         if(t.risk>0){out.maeStopTrades++;out.maeStopUse+=t.mae/t.risk;}
      }
      int weekday=(int)(((long)t.closeTime/86400+4)%7);
      int hour=(int)(((long)t.closeTime/3600)%24);
      if(weekday>=0 && weekday<7) TVAddTradeBucket(out.weekdays[weekday],t);
      if(hour>=0 && hour<24) TVAddTradeBucket(out.hours[hour],t);
      TVAddTradeBucket(out.holding[TVHoldingBucket(t.closeTime-t.openTime)],t);
   }
   TVFinishTradeStats(out.all,losses);TVFinishTradeStats(out.longs,longLosses);TVFinishTradeStats(out.shorts,shortLosses);
   if(startingBalance>0) out.netPercent=100.0*out.all.net/startingBalance;
   if(out.all.grossLoss>0) out.profitFactor=out.all.grossProfit/out.all.grossLoss;
   if(n>0) out.expectancy=out.all.net/n;
   if(out.maxDrawdown>0) out.recovery=out.all.net/out.maxDrawdown;
   if(returns>1 && returnM2>0) out.sharpe=returnMean/MathSqrt(returnM2/(returns-1));
   if(out.riskTrades>0){out.avgRisk=out.risked/out.riskTrades;out.avgR/=out.riskTrades;}
   if(out.maeTrades>0) out.avgMae/=out.maeTrades;
   if(out.maeStopTrades>0) out.maeStopUse/=out.maeStopTrades;
   int order[];
   TVTradeSymbolOrder(trades,order);
   ArrayResize(out.symbols,n);
   int symbols=0;
   for(int i=0;i<n;i++)
   {
      TVClosedTrade t=trades[order[i]];
      if(symbols==0 || out.symbols[symbols-1].symbol!=t.symbol)
      {
         TVResetTradeBucket(out.symbols[symbols]);out.symbols[symbols].symbol=t.symbol;symbols++;
      }
      TVAddTradeBucket(out.symbols[symbols-1],t);
   }
   ArrayResize(out.symbols,symbols);
}
#endif

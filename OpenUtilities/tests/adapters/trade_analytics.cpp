// SPDX-License-Identifier: MIT
// Host adapter compiles the exact pure MQL header after array syntax translation.
#include <algorithm>
#include <cassert>
#include <chrono>
#include <cmath>
#include <iostream>
#include <string>
#include <vector>
using string=std::string;
using datetime=long long;
using ulong=unsigned long long;
#define MathAbs std::fabs
#define MathSqrt std::sqrt
#define MathMax std::max
#define MathMin std::min
int StringCompare(const string &a,const string &b){return a.compare(b);}
template<class T> int ArraySize(const std::vector<T> &a){return (int)a.size();}
template<class T> int ArrayResize(std::vector<T> &a,int n){a.resize(n);return n;}
template<class T,size_t N> int ArraySize(const T (&)[N]){return (int)N;}
#include "TVTradeAnalytics.host.hpp"

void near(double actual,double expected){assert(std::fabs(actual-expected)<1e-8);}
TVTradeDeal deal(ulong ticket,ulong position,int side,int entry,datetime time,double volume,double price,double profit=0,double commission=0,double swap=0,double fee=0,string symbol="EURUSD",double risk=0)
{
   TVTradeDeal d={ticket,position,symbol,side,entry,time,volume,price,profit,commission,swap,fee,risk,time*1000};return d;
}
TVClosedTrade closed(ulong position,int side,datetime open,datetime close,double net,string symbol="EURUSD")
{
   TVClosedTrade t={};t.position=position;t.symbol=symbol;t.side=side;t.volume=1;t.entryPrice=100;t.exitPrice=100+net;t.openTime=open;t.closeTime=close;t.gross=net;t.net=net;return t;
}
int main()
{
   std::vector<TVTradeDeal> deals={
      deal(4,10,-1,1,400,2,140,70,-2,-3,-.2),
      deal(1,10,1,0,100,2,100,0,-2,0,-.2),
      deal(3,10,1,0,300,1,130,0,-1,0,-.1),
      deal(2,10,-1,1,200,1,110,10,-1,-1,-.1)};
   std::vector<TVClosedTrade> trades;
   assert(TVAggregateTrades(deals,trades)==1);
   assert(trades[0].position==10 && trades[0].side==1);
   near(trades[0].volume,3);near(trades[0].entryPrice,110);near(trades[0].exitPrice,130);
   near(trades[0].gross,80);near(trades[0].commission,-6);near(trades[0].swap,-4);near(trades[0].fee,-.6);near(trades[0].net,69.4);
   assert(trades[0].openTime==100 && trades[0].closeTime==400);
   near(TVEntryCommission(deals,10),0);

   // Netting reversal retains one DEAL_POSITION_ID, but starts a new short episode.
   deals={deal(1,20,1,0,100,2,100,0,-2,0,-.2),
          deal(2,20,-1,2,200,3,110,20,-3,-2,-.3),
          deal(3,20,1,1,300,1,90,20,-1,-1,-.1)};
   assert(TVAggregateTrades(deals,trades)==2);
   assert(trades[0].side==1 && trades[1].side==-1);
   near(trades[0].volume,2);near(trades[0].commission,-4);near(trades[0].fee,-.4);near(trades[0].swap,-2);near(trades[0].net,13.6);
   near(trades[1].volume,1);near(trades[1].entryPrice,110);near(trades[1].exitPrice,90);
   near(trades[1].commission,-2);near(trades[1].swap,-1);near(trades[1].fee,-.2);near(trades[1].net,16.8);
   near(trades[0].commission+trades[1].commission,-6);
   near(trades[0].fee+trades[1].fee,-.6);

   // Hedging IDs stay independent; OUT_BY closes are normal exits.
   deals={deal(1,30,1,0,100,1,100,0,-1),deal(2,31,-1,0,100,1,100,0,-1),
          deal(3,30,-1,3,200,1,105,5,-1),deal(4,31,1,3,200,1,105,-5,-1)};
   assert(TVAggregateTrades(deals,trades)==2);near(trades[0].net,3);near(trades[1].net,-7);

   // Missing opening / unresolved partial positions cannot masquerade as closed trades.
   deals={deal(1,40,-1,1,100,1,100,4),deal(2,41,1,0,100,2,100,0,-2),deal(3,41,-1,1,200,1,110,10,-1)};
   assert(TVAggregateTrades(deals,trades)==0);near(TVEntryCommission(deals,41),-1);
   deals.push_back(deal(4,41,-1,2,300,2,120,20,-2));
   TVAggregateTrades(deals,trades);near(TVEntryCommission(deals,41),-1);

   // Hand-calculated net outcomes: +100,-40,-30,+50,-20,+0,+80.
   // Equity: 100,60,30,80,60,60,140. DD: 0,40,70,20,40,40,0.
   // Long +100,-30,-20,+80 = 130. Short -40,+50,0 = 10.
   const datetime monday=1704067200; // 2024-01-01 00:00, broker timestamp.
   trades={closed(1,1,monday,monday+60,100),closed(2,-1,monday,monday+3600,-40,"GBPUSD"),
           closed(3,1,monday,monday+7200,-30),closed(4,-1,monday,monday+14400,50,"GBPUSD"),
           closed(5,1,monday,monday+86400,-20),closed(6,-1,monday,monday+90000,0,"GBPUSD"),
           closed(7,1,monday,monday+172800,80)};
   trades[0].gross=104;trades[0].commission=-2;trades[0].swap=-1;trades[0].fee=-1;
   TVTradeAnalytics a;TVComputeAnalytics(trades,1000,a);
   assert(a.all.trades==7 && a.all.wins==3);near(a.all.net,140);near(a.netPercent,14);
   near(a.profitFactor,23.0/9);near(a.all.grossProfit,230);near(a.all.grossLoss,90);near(a.all.winRate,300.0/7);
   near(a.all.avgWin,230.0/3);near(a.all.avgLoss,30);near(a.all.ratio,23.0/9);
   near(a.all.largestWin,100);near(a.all.largestLoss,40);
   assert(a.all.maxWins==1 && a.all.maxLosses==2);near(a.all.avgSeconds,53494.28571428571);
   near(a.maxDrawdown,70);near(a.maxDrawdownPercent,70.0/1100*100);near(a.expectancy,20);
   near(a.recovery,2);near(a.adverseRun,70);near(a.costs,3);
   double sum=0,sum2=0,equity=1000;
   for(const auto &t:trades){double r=t.net/equity;sum+=r;sum2+=r*r;equity+=t.net;}
   double mean=sum/7,sd=std::sqrt((sum2-7*mean*mean)/6);near(a.sharpe,mean/sd);
   const double expectedEquity[]={100,60,30,80,60,60,140},expectedDD[]={0,40,70,20,40,40,0};
   for(int i=0;i<7;i++){near(a.equity[i],expectedEquity[i]);near(a.drawdown[i],expectedDD[i]);assert(a.times[i]==trades[i].closeTime);}
   assert(a.longs.trades==4 && a.longs.wins==2);near(a.longs.net,130);near(a.longs.grossProfit,180);near(a.longs.grossLoss,50);
   near(a.longs.winRate,50);near(a.longs.avgWin,90);near(a.longs.avgLoss,25);near(a.longs.ratio,3.6);
   near(a.longs.largestWin,100);near(a.longs.largestLoss,30);assert(a.longs.maxWins==1 && a.longs.maxLosses==2);near(a.longs.avgSeconds,66615);
   assert(a.shorts.trades==3 && a.shorts.wins==1);near(a.shorts.net,10);near(a.shorts.grossProfit,50);near(a.shorts.grossLoss,40);
   near(a.shorts.winRate,100.0/3);near(a.shorts.avgWin,50);near(a.shorts.avgLoss,40);near(a.shorts.ratio,1.25);
   near(a.shorts.largestWin,50);near(a.shorts.largestLoss,40);assert(a.shorts.maxWins==1 && a.shorts.maxLosses==1);near(a.shorts.avgSeconds,36000);
   assert(a.symbols.size()==2);assert(a.symbols[0].symbol=="EURUSD");near(a.symbols[0].net,130);near(a.symbols[0].winRate,50);
   assert(a.symbols[1].symbol=="GBPUSD");near(a.symbols[1].net,10);near(a.symbols[1].winRate,100.0/3);
   assert(a.weekdays[1].trades==4 && a.weekdays[2].trades==2 && a.weekdays[3].trades==1);
   near(a.weekdays[1].net,80);near(a.weekdays[2].net,-20);near(a.weekdays[3].net,80);
   assert(a.hours[0].trades==3 && a.hours[1].trades==2 && a.hours[2].trades==1 && a.hours[4].trades==1);
   near(a.hours[0].net,160);near(a.hours[1].net,-40);near(a.hours[2].net,-30);near(a.hours[4].net,50);
   assert(a.holding[0].trades==1 && a.holding[1].trades==0 && a.holding[2].trades==2 && a.holding[3].trades==1 && a.holding[4].trades==3);
   near(a.holding[0].net,100);near(a.holding[2].net,-70);near(a.holding[3].net,50);near(a.holding[4].net,60);

   // Same-second closures use closing deal ticket, rather than position/open order.
   trades={closed(1,1,100,200,-40),closed(2,-1,150,200,50)};
   trades[0].closeTicket=20;trades[1].closeTicket=10;
   TVComputeAnalytics(trades,100,a);assert(trades[0].position==2);near(a.equity[0],50);near(a.maxDrawdown,40);near(a.maxDrawdownPercent,100.0*40/150);
   TVComputeAnalytics(trades,0,a);near(a.netPercent,0);near(a.maxDrawdownPercent,0);near(a.sharpe,0);

   // An exact duplicate snapshot record is idempotently ignored.
   deals={deal(1,42,1,0,100,1,100,0,-1),deal(1,42,1,0,100,1,100,0,-1),deal(2,42,-1,1,200,1,110,10,-1)};
   assert(TVAggregateTrades(deals,trades)==1);near(trades[0].net,8);near(trades[0].volume,1);

   // Equal-volume INOUT is an exit; a smaller INOUT can be a partial exit.
   deals={deal(1,43,1,0,100,2,100,0,-2),deal(2,43,-1,2,200,1,110,10,-1),deal(3,43,-1,2,300,1,120,20,-1)};
   assert(TVAggregateTrades(deals,trades)==1);near(trades[0].exitPrice,115);near(trades[0].net,26);

   // Repeated complete episodes under one ID preserve cash and final open costs.
   deals={deal(1,44,1,0,100,1,100,0,-1),deal(2,44,-1,2,200,2,110,10,-2,-1,-.2),
          deal(3,44,1,2,300,3,90,20,-3,-1,-.3),deal(4,44,-1,1,400,2,100,20,-2,-2,-.2)};
   assert(TVAggregateTrades(deals,trades)==3);
   near(trades[0].commission,-2);near(trades[1].commission,-2);near(trades[2].commission,-4);
   near(trades[0].net,6.9);near(trades[1].net,16.8);near(trades[2].net,13.6);near(TVEntryCommission(deals,44),0);

   // Empty / degenerate ratios are finite and explicitly guarded.
   trades.clear();TVComputeAnalytics(trades,0,a);assert(a.all.trades==0 && a.equity.empty() && a.symbols.empty());near(a.sharpe,0);near(a.netPercent,0);
   trades={closed(1,1,100,200,10)};TVComputeAnalytics(trades,100,a);near(a.all.ratio,0);near(a.recovery,0);near(a.sharpe,0);
   assert(a.all.maxWins==1);near(a.all.winRate,100);

   // Profit factor (sum wins / sum losses) differs from average win/loss ratio.
   trades={closed(1,1,100,160,12),closed(2,1,200,260,6),closed(3,1,300,360,3),closed(4,-1,400,460,-3)};
   TVComputeAnalytics(trades,100,a);near(a.profitFactor,7);near(a.all.ratio,7.0/3);
   near(a.all.avgWin,7);near(a.all.avgLoss,3);near(a.expectancy,4.5);
   assert(a.all.maxWins==3 && a.all.maxLosses==1);near(a.all.winRate,75);near(a.all.avgSeconds,60);

   // Adverse run is consecutive negative net trades, distinct from peak drawdown.
   const double outcomes[]={20,-10,5,-10,0,-12,-8,1};trades.clear();
   for(int i=0;i<8;i++) trades.push_back(closed(i+1,1,100+i*100,160+i*100,outcomes[i]));
   TVComputeAnalytics(trades,100,a);near(a.maxDrawdown,35);near(a.maxDrawdownPercent,100.0*35/120);
   near(a.adverseRun,20);assert(a.all.maxLosses==2);near(a.all.net,-14);near(a.recovery,-.4);
   near(a.all.avgSeconds,60);

   // Initial stop risk: summed over entry fills; a fill without a stop makes the trade's
   // risk unknown; R = net / risk over the trades with a known stop; costs split by kind.
   deals={deal(1,60,1,0,100,1,100,0,-1,0,0,"EURUSD",10),deal(2,60,1,0,110,1,102,0,-1,0,0,"EURUSD",15),deal(3,60,-1,1,200,2,110,50,-2,-3,0),
          deal(4,61,-1,0,300,1,110,0,-1,0,0,"EURUSD",20),deal(5,61,1,1,400,1,115,-5,-1,0,-.5),
          deal(6,62,1,0,500,1,100,0,-1,0,0,"EURUSD",10),deal(7,62,1,0,510,1,100,0,-1),deal(8,62,-1,1,600,2,101,2,-2)};
   assert(TVAggregateTrades(deals,trades)==3);near(trades[0].risk,25);near(trades[1].risk,20);near(trades[2].risk,0);assert(trades[2].riskMissing);
   TVComputeAnalytics(trades,1000,a);assert(a.riskTrades==2 && a.noStopTrades==1);near(a.risked,45);near(a.avgRisk,22.5);near(a.maxRisk,25);
   near(a.avgR,((50-4-3)/25.0+(-5-2-.5)/20.0)/2);near(a.bestR,43/25.0);near(a.worstR,-7.5/20);near(a.commission,-10);near(a.swap,-3);near(a.fee,-.5);
   assert(trades[0].openMsc==100000 && trades[0].closeMsc==200000 && trades[0].mae<0 && a.maeTrades==0);
   // MAE (filled in by the terminal side): average / max over known trades, use of the stop room.
   trades[0].mae=10;trades[1].mae=20;TVComputeAnalytics(trades,1000,a);assert(a.maeTrades==2 && a.maeStopTrades==2);
   near(a.avgMae,15);near(a.maxMae,20);near(a.maeStopUse,(10/25.0+20/20.0)/2);

   // A few thousand deals, reversed input; full aggregate + metrics must be <50 ms.
   deals.clear();for(int i=0;i<3000;i++){deals.push_back(deal(2*i+1,i+1,1,0,100+i*2,1,100,0,-1));deals.push_back(deal(2*i+2,i+1,-1,1,101+i*2,1,101,2,-1));}
   std::reverse(deals.begin(),deals.end());
   auto start=std::chrono::steady_clock::now();assert(TVAggregateTrades(deals,trades)==3000);TVComputeAnalytics(trades,10000,a);
   auto micros=std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now()-start).count();
   assert(micros<50000);std::cout<<"trade analytics: all fixtures passed; 6000 deals + 3000 trades in "<<micros<<" us\n";
}

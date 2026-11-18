// SPDX-License-Identifier: MIT
#ifndef TV_EXIT_UNIT_DOMAIN_MQH
#define TV_EXIT_UNIT_DOMAIN_MQH

enum ENUM_TV_EXIT_UNIT
{
   TV_EXIT_TICKS=0,
   TV_EXIT_PRICE=1,
   TV_EXIT_PRICE_PERCENT=2,
   TV_EXIT_MONEY=3,
   TV_EXIT_EQUITY_PERCENT=4,
   TV_EXIT_PIPS=5
};

struct TVExitInputState
{
   int unit;
   int equivalent;
   string seedText;
   double seedValue;
   double riskDistanceTicks;
};

bool TVExitUnitUsesMoney(const int unit)
{
   return unit==TV_EXIT_MONEY || unit==TV_EXIT_EQUITY_PERCENT;
}

double TVExitDirectTicks(const int unit,const double value,const double entry,
                         const double tick,const double pipTicks,
                         const bool buy,const bool takeProfit)
{
   if(tick<=0.0 || value<=0.0) return 0.0;
   if(unit==TV_EXIT_TICKS) return value;
   if(unit==TV_EXIT_PIPS) return value*pipTicks;
   if(entry<=0.0) return 0.0;
   if(unit==TV_EXIT_PRICE_PERCENT) return entry*value/100.0/tick;
   if(unit==TV_EXIT_PRICE)
   {
      const bool above=buy==takeProfit;
      return (above?value-entry:entry-value)/tick;
   }
   return 0.0;
}

double TVExitDirectValue(const int unit,const double ticks,const double entry,
                         const double tick,const double pipTicks,
                         const bool buy,const bool takeProfit)
{
   if(ticks<=0.0 || tick<=0.0) return 0.0;
   if(unit==TV_EXIT_TICKS) return ticks;
   if(unit==TV_EXIT_PIPS) return pipTicks>0.0?ticks/pipTicks:0.0;
   if(entry<=0.0) return 0.0;
   if(unit==TV_EXIT_PRICE_PERCENT) return ticks*tick/entry*100.0;
   if(unit==TV_EXIT_PRICE) return entry+((buy==takeProfit)?1.0:-1.0)*ticks*tick;
   return 0.0;
}

bool TVExitRectsOverlap(const int ax,const int ay,const int aw,const int ah,
                        const int bx,const int by,const int bw,const int bh)
{
   return aw>0 && ah>0 && bw>0 && bh>0 && ax<bx+bw && ax+aw>bx && ay<by+bh && ay+ah>by;
}

#endif

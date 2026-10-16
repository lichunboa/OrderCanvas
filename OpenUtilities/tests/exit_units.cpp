// SPDX-License-Identifier: MIT
#include <cassert>
#include <cmath>
#include <iostream>
#include <string>
using string=std::string;   // MQL5 string
#include "../MQL5/Include/TVExitUnitDomain.mqh"
static void near(double a,double b){assert(std::fabs(a-b)<1e-9);}
int main()
{
  const double tick=0.01,pip=10.0,entry=2000.0;
  // value -> distance in ticks
  near(TVExitDirectTicks(TV_EXIT_TICKS,200,entry,tick,pip,true,true),200);
  near(TVExitDirectTicks(TV_EXIT_PIPS,20,entry,tick,pip,true,true),200);
  near(TVExitDirectTicks(TV_EXIT_PRICE_PERCENT,0.1,entry,tick,pip,true,true),200);
  near(TVExitDirectTicks(TV_EXIT_PRICE,2002.0,entry,tick,pip,true,true),200);   // buy TP above
  near(TVExitDirectTicks(TV_EXIT_PRICE,1998.0,entry,tick,pip,true,false),200);  // buy SL below
  near(TVExitDirectTicks(TV_EXIT_PRICE,1998.0,entry,tick,pip,false,true),200);  // sell TP below
  near(TVExitDirectTicks(TV_EXIT_PRICE,2002.0,entry,tick,pip,false,false),200); // sell SL above
  assert(TVExitDirectTicks(TV_EXIT_TICKS,0,entry,tick,pip,true,true)==0.0);
  assert(TVExitDirectTicks(TV_EXIT_PRICE,2002.0,0.0,tick,pip,true,true)==0.0);
  assert(TVExitDirectTicks(TV_EXIT_MONEY,10,entry,tick,pip,true,true)==0.0);     // money needs tick value: caller's job
  // distance in ticks -> value, and the round trip
  near(TVExitDirectValue(TV_EXIT_PIPS,200,entry,tick,pip,true,true),20);
  near(TVExitDirectValue(TV_EXIT_PRICE_PERCENT,200,entry,tick,pip,true,true),0.1);
  near(TVExitDirectValue(TV_EXIT_PRICE,200,entry,tick,pip,true,true),2002.0);
  near(TVExitDirectValue(TV_EXIT_PRICE,200,entry,tick,pip,false,true),1998.0);
  for(int unit=0;unit<=5;unit++)
  {
    if(TVExitUnitUsesMoney(unit))continue;
    const double v=TVExitDirectValue(unit,137,entry,tick,pip,true,false);
    near(TVExitDirectTicks(unit,v,entry,tick,pip,true,false),137);
  }
  assert(TVExitUnitUsesMoney(TV_EXIT_MONEY) && TVExitUnitUsesMoney(TV_EXIT_EQUITY_PERCENT) && !TVExitUnitUsesMoney(TV_EXIT_PIPS));
  assert(TVExitRectsOverlap(0,0,10,10,5,5,10,10) && !TVExitRectsOverlap(0,0,10,10,10,0,5,5));
  std::cout<<"PASS: exit distance units (ticks, pips, price, % of price) both ways\n";
}

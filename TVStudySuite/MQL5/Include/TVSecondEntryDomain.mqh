// SPDX-License-Identifier: MPL-2.0
// Native translation of Al Brooks Second Entry, Author PriceActionTrader1.
// Published source: https://www.tradingview.com/script/YUixSlPL-Al-Brooks-Second-Entry/
#ifndef TV_SECOND_ENTRY_DOMAIN_MQH
#define TV_SECOND_ENTRY_DOMAIN_MQH
struct TVSEState{double highest,lowest;int legs,dir;bool waiting,bull,bear;};
TVSEState TVSEInitial(){TVSEState s;s.highest=EMPTY_VALUE;s.lowest=EMPTY_VALUE;s.legs=0;s.dir=0;s.waiting=false;s.bull=false;s.bear=false;return s;}
int TVSEStep(TVSEState &s,const double o,const double h,const double l,const double c,const double ph,const double pl,const double pc,const double biasEMA,const bool strong)
{
 bool bull=c>biasEMA,bear=c<biasEMA,newH=false,newL=false;int resultMask=0;
 if(bull){newH=s.highest==EMPTY_VALUE || h>s.highest;if(newH)s.highest=h;}
 if(bear){newL=s.lowest==EMPTY_VALUE || l<s.lowest;if(newL)s.lowest=l;}
 if((bull && !s.bull)||(bear && !s.bear))
 {s.legs=0;s.dir=0;s.waiting=false;newH=false;newL=false;s.highest=bull?h:EMPTY_VALUE;s.lowest=bear?l:EMPTY_VALUE;}
 if(bull)
 {
  if(newH){s.legs=0;s.dir=0;s.waiting=false;}
  if(h<ph && l<pl){if(s.dir!=-1){s.legs=s.legs==0?1:2;s.dir=-1;s.waiting=true;}}
  if(s.dir==-1 && h>ph){if(s.legs==1){if(s.waiting)resultMask|=1;s.dir=0;}else if(s.legs==2 && s.waiting && (!strong || (c>pc && c>o && c>h-(h-l)*(1.0-0.7))))resultMask|=2;s.waiting=false;}
 }
 if(bear)
 {
  if(newL){s.legs=0;s.dir=0;s.waiting=false;}
  if(l>pl && h>ph){if(s.dir!=1){s.legs=s.legs==0?1:2;s.dir=1;s.waiting=true;}}
  if(s.dir==1 && l<pl){if(s.legs==1){if(s.waiting)resultMask|=4;s.dir=0;}else if(s.legs==2 && s.waiting && (!strong || (c<pc && c<o && c<l+(h-l)*(1.0-0.7))))resultMask|=8;s.waiting=false;}
 }
 s.bull=bull;s.bear=bear;return resultMask;
}
#endif

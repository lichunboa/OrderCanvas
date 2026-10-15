// SPDX-License-Identifier: MIT
#ifndef TV_CANDLE_CLOCK_DOMAIN_MQH
#define TV_CANDLE_CLOCK_DOMAIN_MQH
// Expired bars stay expired until a real new bar is present; never wrap modulo.
long TVCandleSecondsLeft(const long opened,const long ends,const long now)
{if(opened<=0 || ends<=opened || now<opened)return -1;return now>=ends?0:ends-now;}
string TVCandleClockText(const long seconds)
{
 if(seconds<0)return "--:--";
 long days=seconds/86400,hours=(seconds%86400)/3600,minutes=(seconds%3600)/60,rest=seconds%60;
 if(days>0)return StringFormat("%dd %02d:%02d:%02d",(int)days,(int)hours,(int)minutes,(int)rest);
 if(hours>0)return StringFormat("%02d:%02d:%02d",(int)hours,(int)minutes,(int)rest);
 return StringFormat("%02d:%02d",(int)minutes,(int)rest);
}
#endif

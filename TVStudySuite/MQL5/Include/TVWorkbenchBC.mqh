#ifndef TV_WORKBENCH_BC_MQH
#define TV_WORKBENCH_BC_MQH
// SPDX-License-Identifier: MPL-2.0
// Native translation: labmem004, Al Brooks - Bar Count / Al Brooks_BarCount_x.1.
#include "TVStudyObjects.mqh"
#include "TVStudyClock.mqh"
input int BC_EveryXBars=2;
input bool BC_SessionFilter=true;
input bool BC_FuturesSession=false;
input int BC_SpecialMultiple=12;
input int BC_SpecialNumber1=18;
input int BC_SpecialNumber2=18;
input bool BC_EnableSpecialNumbers=true;
input color BC_TextColor=clrGray;
input color BC_MultipleColor=C'228,0,127';
input color BC_SpecialColor=clrAqua;
input int BC_LabelFontSize=10;
input int BC_BrokerWinterUTCMinutes=120;
input bool BC_BrokerUsesUSDST=true;
input int BC_RetainedBars=500;
double BC_count[];bool BC_counting[];string BC_prefix;
int BC_Init(){if(BC_EveryXBars<1 || BC_SpecialMultiple<1 || BC_RetainedBars<10)return INIT_PARAMETERS_INCORRECT;BC_prefix=StudyPrefix("BC");SetIndexBuffer(2,BC_count,INDICATOR_DATA);return INIT_SUCCEEDED;}
void BC_Deinit(const int reason){StudyResetPrefix(BC_prefix);}
int BC_Calculate(const int n,const int prev,const datetime &time[],const double &open[],const double &high[],const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[])
{
 if(n<1)return 0;ArraySetAsSeries(time,false);ArraySetAsSeries(low,false);ArraySetAsSeries(high,false);ArrayResize(BC_counting,n);
 int start=prev>0 && prev<=n?MathMax(0,prev-1):0,first=MathMax(0,n-BC_RetainedBars);if(start==0)StudyResetPrefix(BC_prefix);
 for(int i=start;i<n;i++)
 {
  bool active=i>0?BC_counting[i-1]:false;double value=i>0?BC_count[i-1]:1;
  // Pine dayofweek uses the exchange trading day; IC's chart day is server day.
  if(i==0 || (time[i]/86400)%7!=(time[i-1]/86400)%7){active=false;value=1;}
  bool inside=!BC_SessionFilter || StudyInSession(StudyServerUTC(time[i],BC_BrokerWinterUTCMinutes,BC_BrokerUsesUSDST),BC_FuturesSession);
  if(inside){value=active?value+1:1;active=true;}else active=false;
  BC_count[i]=value;BC_counting[i]=active;if(i<first)continue;string key=StudyKey(BC_prefix,"N",time[i]);int number=(int)value;
  if(active && (number==1 || number%BC_EveryXBars==0))StudyText(key,time[i],low[i]-MathMax((high[i]-low[i])*0.25,15*_Point),IntegerToString(number),BC_EnableSpecialNumbers && (number==BC_SpecialNumber1 || number==BC_SpecialNumber2)?BC_SpecialColor:(number%BC_SpecialMultiple==0?BC_MultipleColor:BC_TextColor),BC_LabelFontSize,ANCHOR_UPPER);else StudyHide(key);
 }
 if(prev!=n)StudyPrune(BC_prefix,time[first]);return n;
}

#endif

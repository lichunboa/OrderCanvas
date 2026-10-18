#ifndef TV_WORKBENCH_SE_MQH
#define TV_WORKBENCH_SE_MQH
// SPDX-License-Identifier: MPL-2.0
// Derived from PriceActionTrader1's Al Brooks Second Entry. See THIRD_PARTY.md.
#include "TVStudyObjects.mqh"
#include "TVSecondEntryDomain.mqh"
#include "TVStudyBadges.mqh"
input bool SE_ShowH1=true;
input bool SE_ShowL1=true;
input bool SE_ShowH2=true;
input bool SE_ShowL2=true;
input bool SE_StrongSignalsOnly=false;
input bool SE_WaitForClose=false; // Current Owner TV setting; live-bar SE_signals can change.
input int SE_PrimaryEMALength=20;
input int SE_LabelFontSize=8;
input int SE_RetainedBars=500;
input bool SE_ClosedSignalAlerts=false;
input color SE_H1Color=C'0,188,212';
input color SE_H2Color=C'76,175,80';
input color SE_L1Color=C'255,152,0';
input color SE_L2Color=C'242,54,69';
input bool SE_SignalBadges=true;
bool SE_AlertNotifications=false; // R3: set through WorkbenchLoadExtension, not an input
double SE_ema[],SE_signals[];TVSEState SE_states[];string SE_prefix;
int SE_Init()
{if(SE_PrimaryEMALength<1 || SE_RetainedBars<10)return INIT_PARAMETERS_INCORRECT;SE_prefix=StudyPrefix("SE");SetIndexBuffer(3,SE_ema,INDICATOR_DATA);SetIndexBuffer(4,SE_signals,INDICATOR_DATA);if(EnableEntrySignals && SE_SignalBadges && !StudyCreateBadges(SE_prefix,SE_LabelFontSize,SE_H1Color,SE_H2Color,SE_L1Color,SE_L2Color))return INIT_FAILED;return INIT_SUCCEEDED;}
void SE_Deinit(const int reason){StudyResetPrefix(SE_prefix);StudyDestroyBadges();}
int SE_Calculate(const int n,const int prev,const datetime &time[],const double &open[],const double &high[],const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[])
{
 if(prev==0)PrintFormat("[STUDY_CALC] %s begin bars=%d",MQLInfoString(MQL_PROGRAM_NAME),n);
 ArraySetAsSeries(time,false);ArraySetAsSeries(open,false);ArraySetAsSeries(high,false);ArraySetAsSeries(low,false);ArraySetAsSeries(close,false);
 if(n<2)return 0;ArrayResize(SE_states,n);int start=prev>0 && prev<=n?MathMax(1,prev-1):1;
 if(start==1){StudyResetPrefix(SE_prefix);SE_ema[0]=close[0];SE_states[0]=TVSEInitial();SE_states[0].bull=false;SE_states[0].bear=false;SE_signals[0]=0;}
 double alpha=2.0/(SE_PrimaryEMALength+1);int first=MathMax(1,n-SE_RetainedBars);
 for(int i=start;i<n;i++)
 {
  SE_ema[i]=SE_ema[i-1]+alpha*(close[i]-SE_ema[i-1]);SE_states[i]=SE_states[i-1];SE_signals[i]=0;
  if(!SE_WaitForClose || i<n-1)SE_signals[i]=TVSEStep(SE_states[i],open[i],high[i],low[i],close[i],high[i-1],low[i-1],close[i-1],SE_ema[i],SE_StrongSignalsOnly);
  if(i<first)continue;double pad=MathMax((high[i]-low[i])*0.15,10*_Point);string roles[]={"H1","H2","L1","L2"};color inks[]={SE_H1Color,SE_H2Color,SE_L1Color,SE_L2Color};bool enabled[]={SE_ShowH1,SE_ShowH2,SE_ShowL1,SE_ShowL2};
  for(int k=0;k<4;k++){string key=StudyKey(SE_prefix,roles[k],time[i]);if(enabled[k] && ((((int)SE_signals[i])&(1<<k))!=0)){double price=k<2?low[i]-pad:high[i]+pad;if(SE_SignalBadges)StudyBadge(key,time[i],price,k);else StudyText(key,time[i],price,roles[k],inks[k],SE_LabelFontSize,k<2?ANCHOR_UPPER:ANCHOR_LOWER);}else StudyHide(key);}
 }
 if(prev!=n)StudyPrune(SE_prefix,time[first]);
 if(SE_ClosedSignalAlerts && prev>0 && n>prev)
 {
  string roles[]={"H1","H2","L1","L2"};bool enabled[]={SE_ShowH1,SE_ShowH2,SE_ShowL1,SE_ShowL2};
  for(int i=MathMax(1,prev-1);i<n-1;i++)for(int k=0;k<4;k++)if(enabled[k] && (((int)SE_signals[i]&(1<<k))!=0))
  {string message=StudySignalMessage(time[i],roles[k],"");StudyToast(message);if(SE_AlertNotifications)SendNotification(message);}
 }
 return n;
}

#endif

#ifndef TV_WORKBENCH_PA_MQH
#define TV_WORKBENCH_PA_MQH
// SPDX-License-Identifier: MPL-2.0
// Native translation of PAIO by fengyangsi, scoped to Owner's active features.
// https://www.tradingview.com/script/n78QYp0G-Price-Action-All-In-One/
#include "TVStudyObjects.mqh"
input bool PA_OpenGaps=true;
input bool PA_WickGaps=true;
input bool PA_WickExceptOpen=true;
input bool PA_BodyGaps=true;
input bool PA_BodyExceptOpen=true;
input bool PA_BodyExceptWick=true;
input int PA_ChartEMALength=20;
input int PA_ThirdEMALength=200;                       // EMA 200 of the chart's own timeframe (Owner round 27)
input ENUM_TIMEFRAMES PA_ThirdEMATimeframe=PERIOD_CURRENT;
input bool PA_PreviousValues=false; // Current Owner: D1 low / high / low, chart based, all.
input bool PA_UseOO=true;
input bool PA_UseII=true;
input bool PA_UseIOI=true;
input color PA_IOTextColor=clrOlive;
input int PA_IOFontSize=12;
input int PA_RetainedBars=500;
input bool PA_ShowChartEMA=true;
input bool PA_ShowThirdEMA=true;
input bool PA_ShowPreviousClose=false;
input color PA_ChartEMAColor=clrDodgerBlue;
input ENUM_LINE_STYLE PA_ChartEMAStyle=STYLE_DASH;
input int PA_ChartEMAWidth=1;
input color PA_ThirdEMAColor=clrSlateBlue;
input ENUM_LINE_STYLE PA_ThirdEMAStyle=STYLE_DASH;
input int PA_ThirdEMAWidth=1;
// R3 style/alert fields. Not inputs: MT5 IndicatorCreate accepts at most 64
// parameters, so the panel hands these over in a revision-tagged file
// (WorkbenchLoadExtension). Owner-active Previous Values: high + one
// deduplicated low, D1 / chart / All / line.
color PA_PVHighColor=C'242,54,69';
color PA_PVLowColor=C'8,153,129';
ENUM_LINE_STYLE PA_PVHighStyle=STYLE_DASH;
int PA_PVHighWidth=1;
ENUM_LINE_STYLE PA_PVLowStyle=STYLE_DASH;
int PA_PVLowWidth=1;
bool PA_AlertOpen=false;
bool PA_AlertWick=false;
bool PA_AlertBody=false;
bool PA_AlertPatterns=false;
bool PA_AlertNotifications=false;
color PA_OpenUpColor=C'8,153,129';
color PA_OpenDownColor=C'242,54,69';
color PA_WickUpColor=C'8,153,129';
color PA_WickDownColor=C'242,54,69';
color PA_BodyUpColor=C'8,153,129';
color PA_BodyDownColor=C'242,54,69';
double PA_ema[],PA_mtf[],PA_emaCalc[];MqlRates PA_sourceBars[];double PA_sourceEMA[];string PA_prefix;
struct PA_PAIOState{int oo,ii,ioi,ooRun,iiRun;string ooText,iiText,ioiText;double dayH,dayL,prevH,prevL,prevC;};
PA_PAIOState PA_states[];
bool PA_OO(const int i,const double &h[],const double &l[]){return i>=2 && h[i]>=h[i-1] && l[i]<=l[i-1] && h[i-1]>=h[i-2] && l[i-1]<=l[i-2] && (h[i]!=h[i-1] || l[i]!=l[i-1]);}
bool PA_II(const int i,const double &h[],const double &l[]){return i>=2 && h[i]<=h[i-1] && l[i]>=l[i-1] && h[i-1]<=h[i-2] && l[i-1]>=l[i-2] && (h[i]!=h[i-1] || l[i]!=l[i-1]);}
bool PA_IOI(const int i,const double &h[],const double &l[]){return i>=2 && h[i]<=h[i-1] && l[i]>=l[i-1] && h[i-1]>=h[i-2] && l[i-1]<=l[i-2];}
string PA_RepeatLetter(const string letter,const int n){string value="";for(int i=0;i<n;i++)value+=letter;return value;}
void PA_IOLabel(const string role,const int anchor,const string text,const datetime &time[],const double &high[],const double &low[],const int first)
{if(anchor<first || anchor<0)return;StudyText(StudyKey(PA_prefix,role,time[anchor]),time[anchor],high[anchor]+MathMax((high[anchor]-low[anchor])*0.25,20*_Point),text,PA_IOTextColor,PA_IOFontSize,ANCHOR_LOWER);}
// Seed ta.ema from the first available source close, including length=1.
// Only the current source bar and newly arrived source bars are copied/replayed.
bool PA_RefreshSource(const bool reset)
{
 MqlRates incoming[];int copied=0;
 int old=ArraySize(PA_sourceBars);
 if(reset || old==0){copied=CopyRates(_Symbol,PA_ThirdEMATimeframe,0,Bars(_Symbol,PA_ThirdEMATimeframe),incoming);if(copied<=0)return false;ArrayResize(PA_sourceBars,copied);for(int j=0;j<copied;j++)PA_sourceBars[j]=incoming[j];old=0;}
 else
 {
  copied=CopyRates(_Symbol,PA_ThirdEMATimeframe,PA_sourceBars[old-1].time,TimeCurrent(),incoming);if(copied<=0)return false;
  // Last open bar is rolled back before each tick, exactly like Pine var state.
  ArrayResize(PA_sourceBars,old-1+copied);for(int j=0;j<copied;j++)PA_sourceBars[old-1+j]=incoming[j];
 }
 int size=ArraySize(PA_sourceBars);ArrayResize(PA_sourceEMA,size);
 int start=old>0?old-1:0;
 for(int j=start;j<size;j++)PA_sourceEMA[j]=j==0?PA_sourceBars[j].close:PA_sourceEMA[j-1]+2.0/(PA_ThirdEMALength+1)*(PA_sourceBars[j].close-PA_sourceEMA[j-1]);
 return true;
}
int PA_SourceIndex(const datetime t)
{int lo=0,hi=ArraySize(PA_sourceBars)-1,result=-1;while(lo<=hi){int mid=(lo+hi)/2;if(PA_sourceBars[mid].time<=t){result=mid;lo=mid+1;}else hi=mid-1;}return result;}
double PA_SourceValue(const datetime t,const double c,const bool realtime)
{
 datetime boundary=t+PeriodSeconds(_Period);int index=PA_SourceIndex(realtime?TimeCurrent():boundary-1);
 if(index<0)return EMPTY_VALUE;
 if(realtime || boundary>=PA_sourceBars[index].time+PeriodSeconds(PA_ThirdEMATimeframe))return PA_sourceEMA[index];
 return index>0?PA_sourceEMA[index-1]+2.0/(PA_ThirdEMALength+1)*(c-PA_sourceEMA[index-1]):EMPTY_VALUE;
}
void PA_Notify(const datetime t,const string event)
{string message=StudySignalMessage(t,event,"PAIO: ");StudyToast(message);if(PA_AlertNotifications)SendNotification(message);}
int PA_Init()
{
 if(PA_ChartEMALength<1 || PA_ThirdEMALength<1 || PA_RetainedBars<10 || PA_ChartEMAWidth<1 || PA_ChartEMAWidth>5 || PA_ThirdEMAWidth<1 || PA_ThirdEMAWidth>5 || PA_PVHighWidth<1 || PA_PVHighWidth>5 || PA_PVLowWidth<1 || PA_PVLowWidth>5)return INIT_PARAMETERS_INCORRECT;
 PA_prefix=StudyPrefix("PAIO");SetIndexBuffer(0,PA_ema,INDICATOR_DATA);SetIndexBuffer(1,PA_mtf,INDICATOR_DATA);SetIndexBuffer(5,PA_emaCalc,INDICATOR_CALCULATIONS);IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
 PlotIndexSetInteger(0,PLOT_LINE_COLOR,PA_ChartEMAColor);PlotIndexSetInteger(0,PLOT_LINE_STYLE,PA_ChartEMAStyle);PlotIndexSetInteger(0,PLOT_LINE_WIDTH,PA_ChartEMAWidth);
 PlotIndexSetInteger(1,PLOT_LINE_COLOR,PA_ThirdEMAColor);PlotIndexSetInteger(1,PLOT_LINE_STYLE,PA_ThirdEMAStyle);PlotIndexSetInteger(1,PLOT_LINE_WIDTH,PA_ThirdEMAWidth);
 return INIT_SUCCEEDED;
}
void PA_Deinit(const int reason){StudyResetPrefix(PA_prefix);ArrayResize(PA_sourceBars,0);ArrayResize(PA_sourceEMA,0);}
int PA_Calculate(const int n,const int prev,const datetime &time[],const double &open[],const double &high[],const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[])
{
 if(n<3)return 0;ArraySetAsSeries(time,false);ArraySetAsSeries(open,false);ArraySetAsSeries(high,false);ArraySetAsSeries(low,false);ArraySetAsSeries(close,false);ArrayResize(PA_states,n);
 bool reset=prev<=0 || prev>n;
 bool sameTF=PA_ThirdEMATimeframe==PERIOD_CURRENT || PA_ThirdEMATimeframe==_Period;
 if(PA_ShowThirdEMA && !sameTF && !PA_RefreshSource(reset))return 0;
 int start=reset?1:MathMax(1,prev-1),first=MathMax(0,n-PA_RetainedBars);
 if(start==1){StudyResetPrefix(PA_prefix);PA_emaCalc[0]=close[0];PA_ema[0]=PA_ShowChartEMA?close[0]:EMPTY_VALUE;PA_mtf[0]=PA_ShowThirdEMA?(sameTF?close[0]:PA_SourceValue(time[0],close[0],false)):EMPTY_VALUE;PA_PAIOState initial;initial.oo=-1;initial.ii=-1;initial.ioi=-1;initial.ooRun=0;initial.iiRun=0;initial.dayH=high[0];initial.dayL=low[0];initial.prevH=EMPTY_VALUE;initial.prevL=EMPTY_VALUE;initial.prevC=EMPTY_VALUE;initial.ooText="";initial.iiText="";initial.ioiText="";PA_states[0]=initial;}
 for(int i=start;i<n;i++)
 {
  PA_emaCalc[i]=PA_emaCalc[i-1]+2.0/(PA_ChartEMALength+1)*(close[i]-PA_emaCalc[i-1]);PA_ema[i]=PA_ShowChartEMA?PA_emaCalc[i]:EMPTY_VALUE;
  // request.security(..., gaps_on): historical HTF values appear at source
  // close; otherwise converge from the last confirmed EMA without reseeding.
  PA_mtf[i]=EMPTY_VALUE;
  if(PA_ShowThirdEMA)
  {
   if(sameTF)PA_mtf[i]=i==1?close[0]+2.0/(PA_ThirdEMALength+1)*(close[i]-close[0]):PA_mtf[i-1]+2.0/(PA_ThirdEMALength+1)*(close[i]-PA_mtf[i-1]);
   else PA_mtf[i]=PA_SourceValue(time[i],close[i],i==n-1);
  }

  PA_states[i]=PA_states[i-1];PA_PAIOState s=PA_states[i];
  if(time[i]/86400!=time[i-1]/86400){s.prevH=s.dayH;s.prevL=s.dayL;s.prevC=close[i-1];s.dayH=high[i];s.dayL=low[i];}
  else{s.dayH=MathMax(s.dayH,high[i]);s.dayL=MathMin(s.dayL,low[i]);}
  bool oo=PA_OO(i,high,low),ii=PA_II(i,high,low),ioi=PA_IOI(i,high,low);s.ooRun=oo?s.ooRun+1:0;s.iiRun=ii?s.iiRun+1:0;
  if(i>=first)
  {
   // Restore prior labels before replaying the live bar (Pine intrabar rollback).
   PA_IOLabel("PA_OO",s.oo,s.ooText,time,high,low,first);PA_IOLabel("PA_II",s.ii,s.iiText,time,high,low,first);PA_IOLabel("PA_IOI",s.ioi,s.ioiText,time,high,low,first);
   string roles[]={"OPEN","WICK","BODY","PA_OO","PA_II"};for(int k=0;k<5;k++)StudyHide(StudyKey(PA_prefix,roles[k],time[i]));StudyHide(StudyKey(PA_prefix,"PA_IOI",time[i-1]));
   bool up=low[i]>high[i-1],down=high[i]<low[i-1],prevUp=i>=2 && low[i-1]>high[i-2],prevDown=i>=2 && high[i-1]<low[i-2];
   if(PA_OpenGaps && (up||down))StudyBox(StudyKey(PA_prefix,"OPEN",time[i]),time[i-1],time[i],up?low[i]:low[i-1],up?high[i-1]:high[i],StudyBlend(up?PA_OpenUpColor:PA_OpenDownColor,0.60));
   bool wickUp=i>=2 && low[i]>high[i-2],wickDown=i>=2 && high[i]<low[i-2];
   if(PA_WickGaps && ((wickUp && (!PA_WickExceptOpen || (!up && !prevUp))) || (wickDown && (!PA_WickExceptOpen || (!down && !prevDown)))))StudyBox(StudyKey(PA_prefix,"WICK",time[i]),time[i-2],time[i],wickUp?low[i]:low[i-2],wickUp?high[i-2]:high[i],StudyBlend(wickUp?PA_WickUpColor:PA_WickDownColor,0.40));
   if(i>=2 && PA_BodyGaps)
   {
    double hi=MathMax(open[i],close[i]),lo=MathMin(open[i],close[i]),pHi=MathMax(open[i-2],close[i-2]),pLo=MathMin(open[i-2],close[i-2]);bool bodyUp=lo>pHi,bodyDown=hi<pLo;
    // Preserve original asymmetric bearish exclusions verbatim in semantics.
    if((bodyUp && (!PA_BodyExceptOpen || (!up && !prevUp)) && (!PA_BodyExceptWick || !wickUp)) || (bodyDown && (!PA_BodyExceptOpen || (!wickDown && !down)) && (!PA_BodyExceptWick || !prevDown)))StudyBox(StudyKey(PA_prefix,"BODY",time[i]),time[i-2],time[i],bodyUp?lo:pLo,bodyUp?pHi:hi,StudyBlend(bodyUp?PA_BodyUpColor:PA_BodyDownColor,0.20));
   }
   if(time[i]/86400!=time[i-1]/86400)
   {
    datetime end=(datetime)((time[i]/86400+2)*86400);
    if(PA_PreviousValues){StudyLine(StudyKey(PA_prefix,"PVHIGH",time[i]),time[i],end,s.prevH,PA_PVHighColor,PA_PVHighStyle,PA_PVHighWidth);StudyLine(StudyKey(PA_prefix,"PVLOW",time[i]),time[i],end,s.prevL,PA_PVLowColor,PA_PVLowStyle,PA_PVLowWidth);}
    if(PA_ShowPreviousClose)StudyLine(StudyKey(PA_prefix,"PVCLOSE",time[i]),time[i],end,s.prevC,clrSilver);
   }
  }
  if(oo && PA_UseOO){int run=s.ooRun-1;if(s.oo>=0 && s.oo+run==i)s.ooText=PA_RepeatLetter("o",run+2);else{s.oo=i;s.ooText="oo";}PA_IOLabel("PA_OO",s.oo,s.ooText,time,high,low,first);}
  if(ii && PA_UseII){int run=s.iiRun-1;if(s.ii>=0 && s.ii+run==i)s.iiText=PA_RepeatLetter("i",run+2);else if(s.ioi>=0 && s.ioi+2+run==i)s.ioiText="ioi"+PA_RepeatLetter("i",run+1);else if(!ioi){s.ii=i;s.iiText="ii";}PA_IOLabel("PA_II",s.ii,s.iiText,time,high,low,first);PA_IOLabel("PA_IOI",s.ioi,s.ioiText,time,high,low,first);}
  if(ioi && PA_UseIOI){s.ioi=i-1;s.ioiText="ioi";int run=PA_states[i-1].ooRun;if(s.oo>=0 && s.oo+run==i){if(s.oo>=first)StudyHide(StudyKey(PA_prefix,"PA_OO",time[s.oo]));s.oo=-1;s.ioiText=PA_RepeatLetter("i",run)+"ioi";}PA_IOLabel("PA_IOI",s.ioi,s.ioiText,time,high,low,first);}
  PA_states[i]=s;
  // Source alertconditions are independent of visualization/exclusion switches.
  // Deliver only freshly closed bars, never history initialization or each tick.
  if(prev>0 && i>=prev-1 && i<n-1)
  {
   if(PA_AlertOpen){if(low[i]>high[i-1])PA_Notify(time[i],"Gap Up(Open)");else if(high[i]<low[i-1])PA_Notify(time[i],"Gap Down(Open)");}
   if(i>=2 && PA_AlertWick){if(low[i]>high[i-2])PA_Notify(time[i],"Gap Up(Wick)");else if(high[i]<low[i-2])PA_Notify(time[i],"Gap Down(Wick)");}
   if(i>=2 && PA_AlertBody){if(MathMin(open[i],close[i])>MathMax(open[i-2],close[i-2]))PA_Notify(time[i],"Gap Up(Body)");else if(MathMax(open[i],close[i])<MathMin(open[i-2],close[i-2]))PA_Notify(time[i],"Gap Down(Body)");}
   if(PA_AlertPatterns){if(oo)PA_Notify(time[i],"OO");if(ii)PA_Notify(time[i],"II");if(ioi)PA_Notify(time[i],"IOI");}
  }
 }
 if(prev!=n)StudyPrune(PA_prefix,time[first]);return n;
}

#endif

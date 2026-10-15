// SPDX-License-Identifier: MPL-2.0
// Unified native workbench. Original module attribution: Indicators/THIRD_PARTY.md.
#property strict
#property copyright "Price Action Workbench; MPL-2.0 source acknowledgements in THIRD_PARTY.md"
#property version "1.07" // = OrderCanvas OC_VERSION 1.0.7
#property indicator_chart_window
#property indicator_buffers 6
#property indicator_plots 5
#property indicator_type1 DRAW_LINE
#property indicator_label1 "图表均线"
#property indicator_type2 DRAW_LINE
#property indicator_label2 "另一周期均线"
#property indicator_type3 DRAW_NONE
#property indicator_label3 "K线计数"
#property indicator_type4 DRAW_NONE
#property indicator_label4 "入场参考均线"
#property indicator_type5 DRAW_NONE
#property indicator_label5 "入场信号 H1=1 H2=2 L1=4 L2=8"
#include "../Include/TVWorkbenchDomain.mqh"
input group "工作台模块"
input bool EnablePriceAction=true;
input bool EnableBarCount=true;
input bool EnableEntrySignals=true;
input group "均线与形态"
#include "../Include/TVWorkbenchPA.mqh"
input group "K线计数"
#include "../Include/TVWorkbenchBC.mqh"
input group "入场信号"
#include "../Include/TVWorkbenchSE.mqh"
// Internal lifecycle revision prevents MT5 from reviving a detached cached renderer.
sinput long WorkbenchInstance=0;
// Panel-created instances carry their R3 style/alert values in a per-chart file
// tagged with the same revision (see TV_WORKBENCH_PARAMS).
void WorkbenchLoadExtension()
{
 if(WorkbenchInstance<=0)return;
 const int f=FileOpen(WorkbenchExtensionFile(ChartID()),FILE_READ|FILE_TXT|FILE_ANSI|FILE_SHARE_READ);if(f==INVALID_HANDLE)return;
 const string head=FileReadString(f);const long revision=StringToInteger(FileReadString(f));
 long v[TV_WORKBENCH_EXT_VALUES];int n=0;while(n<TV_WORKBENCH_EXT_VALUES && !FileIsEnding(f))v[n++]=StringToInteger(FileReadString(f));
 FileClose(f);
 if(head!="TVSTUDYEXT1" || revision!=WorkbenchInstance || n!=TV_WORKBENCH_EXT_VALUES)return;
 PA_PVHighColor=(color)v[0];PA_PVLowColor=(color)v[1];PA_PVHighStyle=(ENUM_LINE_STYLE)v[2];PA_PVHighWidth=(int)v[3];PA_PVLowStyle=(ENUM_LINE_STYLE)v[4];PA_PVLowWidth=(int)v[5];
 PA_AlertOpen=v[6]!=0;PA_AlertWick=v[7]!=0;PA_AlertBody=v[8]!=0;PA_AlertPatterns=v[9]!=0;PA_AlertNotifications=v[10]!=0;
 PA_OpenUpColor=(color)v[11];PA_OpenDownColor=(color)v[12];PA_WickUpColor=(color)v[13];PA_WickDownColor=(color)v[14];PA_BodyUpColor=(color)v[15];PA_BodyDownColor=(color)v[16];
 SE_AlertNotifications=v[17]!=0;
}
int OnInit()
{
 WorkbenchLoadExtension();
 int a=PA_Init(),b=BC_Init(),c=SE_Init();
 if(a!=INIT_SUCCEEDED || b!=INIT_SUCCEEDED || c!=INIT_SUCCEEDED)
 {PrintFormat("[WORKBENCH_INIT_FAILED] symbol=%s period=%s PA=%d BC=%d SE=%d error=%d",_Symbol,EnumToString(_Period),a,b,c,GetLastError());return INIT_FAILED;}
 const string prefixes[]={PA_prefix,BC_prefix,SE_prefix};const string roots[]={"TVST_PAIO_","TVST_BC_","TVST_SE_"};
 for(int i=0;i<3;i++)GlobalVariableSet("TVST.Workbench.Active."+IntegerToString(ChartID())+"."+IntegerToString(i),(double)StringToInteger(StringSubstr(prefixes[i],StringLen(roots[i]))));
 IndicatorSetString(INDICATOR_SHORTNAME,TV_WORKBENCH_NAME);
 EventSetTimer(1); // expires signal toasts (StudyToastTick)
 PlotIndexSetInteger(0,PLOT_DRAW_TYPE,EnablePriceAction && PA_ShowChartEMA?DRAW_LINE:DRAW_NONE);
 PlotIndexSetInteger(1,PLOT_DRAW_TYPE,EnablePriceAction && PA_ShowThirdEMA?DRAW_LINE:DRAW_NONE);
 return INIT_SUCCEEDED;
}
void OnTimer(){StudyToastTick();}
void OnDeinit(const int reason){EventKillTimer();StudyToastClear();PrintFormat("[STUDY_CACHE] commands=%I64u skipped=%I64u",studyCacheCommands,studyCacheSkips);PA_Deinit(reason);BC_Deinit(reason);SE_Deinit(reason);StudyReset();}
void EmptyModuleBuffer(double &buffer[],const int n,const int prev)
{for(int i=prev>0 && prev<=n?MathMax(0,prev-1):0;i<n;i++)buffer[i]=EMPTY_VALUE;}
int OnCalculate(const int n,const int prev,const datetime &time[],const double &open[],const double &high[],const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[])
{
 if(n<3)return 0;ulong startUs=GetMicrosecondCount();if(prev==0)PrintFormat("[WORKBENCH_CALC] begin bars=%d",n);
 if(EnablePriceAction){if(PA_Calculate(n,prev,time,open,high,low,close,tick_volume,volume,spread)==0)return 0;}
 else{EmptyModuleBuffer(PA_ema,n,prev);EmptyModuleBuffer(PA_mtf,n,prev);EmptyModuleBuffer(PA_emaCalc,n,prev);}
 if(prev==0)PrintFormat("[WORKBENCH_CALC] price_action_us=%I64u",GetMicrosecondCount()-startUs);
 if(EnableBarCount)BC_Calculate(n,prev,time,open,high,low,close,tick_volume,volume,spread);else EmptyModuleBuffer(BC_count,n,prev);
 if(prev==0)PrintFormat("[WORKBENCH_CALC] bar_count_us=%I64u",GetMicrosecondCount()-startUs);
 if(EnableEntrySignals)SE_Calculate(n,prev,time,open,high,low,close,tick_volume,volume,spread);
 else{EmptyModuleBuffer(SE_ema,n,prev);EmptyModuleBuffer(SE_signals,n,prev);}
 if(prev==0)PrintFormat("[WORKBENCH_CALC] ready bars=%d elapsed_us=%I64u",n,GetMicrosecondCount()-startUs);return n;
}

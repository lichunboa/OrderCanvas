#ifndef TV_STUDY_BADGES_MQH
#define TV_STUDY_BADGES_MQH
#include <Canvas/Canvas.mqh>
// Four shared, price/time-anchored resources per study instance. No chart geometry
// queries from an indicator calculation, and no per-tick bitmap uploads.
CCanvas studyBadges[4];bool studyBadgesReady=false;
void StudyDestroyBadges(){for(int i=0;i<4;i++)studyBadges[i].Destroy();studyBadgesReady=false;}
bool StudyCreateBadges(const string instance,const int font,const color h1,const color h2,const color l1,const color l2)
{
 const string text[]={"H1","H2","L1","L2"};const color bg[]={h1,h2,l1,l2};
 for(int i=0;i<4;i++)
 {
  // Font metrics match native point-sized text, independent of chart zoom.
  studyBadges[i].FontSet("Arial",-font*10);int w=studyBadges[i].TextWidth(text[i])+10,body=studyBadges[i].TextHeight(text[i])+6,tip=5,h=body+tip;
  if(!studyBadges[i].Create(instance+text[i],w,h,COLOR_FORMAT_ARGB_NORMALIZE)){StudyDestroyBadges();return false;}
  studyBadges[i].Erase(0);uint ink=ColorToARGB(bg[i],255);int y=i<2?tip:0,bottom=y+body-1,rad=3;
  studyBadges[i].FillRectangle(rad,y,w-rad-1,bottom,ink);studyBadges[i].FillRectangle(0,y+rad,w-1,bottom-rad,ink);
  studyBadges[i].FillCircle(rad,y+rad,rad,ink);studyBadges[i].FillCircle(w-rad-1,y+rad,rad,ink);studyBadges[i].FillCircle(rad,bottom-rad,rad,ink);studyBadges[i].FillCircle(w-rad-1,bottom-rad,rad,ink);
  studyBadges[i].FillTriangle(w/2-tip,i<2?tip:body-1,w/2+tip,i<2?tip:body-1,w/2,i<2?0:h-1,ink);
  studyBadges[i].FontSet("Arial",-font*10);studyBadges[i].TextOut((w-studyBadges[i].TextWidth(text[i]))/2,y+3,text[i],ColorToARGB(C'41,98,255',255));studyBadges[i].Update(false);
 }
 studyBadgesReady=true;Print("[STUDY_BADGES] resources=4 uploads=4 instance=",instance);return true;
}
void StudyBadge(const string key,const datetime t,const double price,const int role)
{
 if(!studyBadgesReady || role<0 || role>3)return;
 if(StudyNew(key,t))
 {
  ObjectCreate(0,key,OBJ_BITMAP,0,t,price);ObjectSetString(0,key,OBJPROP_BMPFILE,studyBadges[role].ResourceName());ObjectSetInteger(0,key,OBJPROP_XSIZE,studyBadges[role].Width());ObjectSetInteger(0,key,OBJPROP_YSIZE,studyBadges[role].Height());ObjectSetInteger(0,key,OBJPROP_SELECTABLE,false);ObjectSetInteger(0,key,OBJPROP_HIDDEN,true);ObjectSetInteger(0,key,OBJPROP_BACK,false);   /* H1 / L1 badges in front of the grid (Owner 2026-10-16) */ObjectSetInteger(0,key,OBJPROP_ANCHOR,role<2?ANCHOR_UPPER:ANCHOR_LOWER);const string hints[]={"H1 · 入场信号","H2 · 入场信号","L1 · 入场信号","L2 · 入场信号"};ObjectSetString(0,key,OBJPROP_TOOLTIP,hints[role]);
 }
 int index=StudyIndex(key);if(index<0)return;
 StudyMoveCached(index,key,0,t,price);StudySetInt(index,key,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
}
#endif

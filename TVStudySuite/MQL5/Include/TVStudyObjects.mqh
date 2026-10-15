#ifndef TV_STUDY_OBJECTS_MQH
#define TV_STUDY_OBJECTS_MQH
#include <Generic/HashMap.mqh>
// Native study presentation only. Namespaces never overlap ticket/trade objects.
// Indicator calculation must not synchronously query the chart while an EA
// is waiting for iCustom/ChartIndicatorAdd. Own a bounded local object registry.
string studyKeys[];datetime studyTimes[];
// One owned presentation record per registry slot; no synchronous chart reads.
struct TVStudyPaintState{bool created;uint pointMask,intMask;datetime time[2];double price[2];long integers[6];string text;bool textKnown;};
TVStudyPaintState studyPaint[];ulong studyCacheCommands=0,studyCacheSkips=0;
int StudyIntSlot(const ENUM_OBJECT_PROPERTY_INTEGER property)
{return property==OBJPROP_COLOR?0:(property==OBJPROP_FONTSIZE?1:(property==OBJPROP_ANCHOR?2:(property==OBJPROP_STYLE?3:(property==OBJPROP_TIMEFRAMES?4:(property==OBJPROP_WIDTH?5:-1)))));}
void StudySetInt(const int index,const string key,const ENUM_OBJECT_PROPERTY_INTEGER property,const long value)
{
 int slot=StudyIntSlot(property);uint bit=slot>=0?(uint)(1<<slot):0;
 if(slot>=0 && (studyPaint[index].intMask&bit)!=0 && studyPaint[index].integers[slot]==value){studyCacheSkips++;return;}
 studyCacheCommands++;if(ObjectSetInteger(0,key,property,value) && slot>=0){studyPaint[index].integers[slot]=value;studyPaint[index].intMask|=bit;}
}
void StudyMoveCached(const int index,const string key,const int point,const datetime time,const double price)
{
 uint bit=(uint)(1<<point);if((studyPaint[index].pointMask&bit)!=0 && studyPaint[index].time[point]==time && studyPaint[index].price[point]==price){studyCacheSkips++;return;}
 studyCacheCommands++;if(ObjectMove(0,key,point,time,price)){studyPaint[index].time[point]=time;studyPaint[index].price[point]=price;studyPaint[index].pointMask|=bit;}
}
void StudySetText(const int index,const string key,const string text)
{
 if(studyPaint[index].textKnown && studyPaint[index].text==text){studyCacheSkips++;return;}
 studyCacheCommands++;if(ObjectSetString(0,key,OBJPROP_TEXT,text)){studyPaint[index].text=text;studyPaint[index].textKnown=true;}
}
CHashMap<string,int> studyIndexMap;bool studyIndexHealthy=true;
void StudyReindex()
{studyIndexMap.Clear();studyIndexHealthy=true;for(int i=0;i<ArraySize(studyKeys);i++)if(!studyIndexMap.Add(studyKeys[i],i))studyIndexHealthy=false;}
int StudyIndex(const string key)
{
 if(studyIndexHealthy){int index=-1;return studyIndexMap.TryGetValue(key,index)?index:-1;}
 for(int i=0;i<ArraySize(studyKeys);i++)if(studyKeys[i]==key)return i;return -1;
}
bool StudyNew(const string key,const datetime t)
{
 if(StudyIndex(key)>=0)return false;int n=ArraySize(studyKeys);ArrayResize(studyKeys,n+1,256);ArrayResize(studyTimes,n+1,256);ArrayResize(studyPaint,n+1,256);ZeroMemory(studyPaint[n]);studyKeys[n]=key;studyTimes[n]=t;
 if(studyIndexHealthy && !studyIndexMap.Add(key,n))studyIndexHealthy=false;return true;
}
void StudyReset(){for(int i=0;i<ArraySize(studyKeys);i++)ObjectDelete(0,studyKeys[i]);ArrayResize(studyKeys,0);ArrayResize(studyTimes,0);ArrayResize(studyPaint,0);studyIndexMap.Clear();studyIndexHealthy=true;}
// Each unified module cleans only its own namespace; indexed lookup avoids
// turning three standalone registries into one per-tick quadratic scan.
void StudyResetPrefix(const string studyNamespace)
{
 bool removed=false;for(int i=ArraySize(studyKeys)-1;i>=0;i--)if(StringFind(studyKeys[i],studyNamespace)==0)
 {ObjectDelete(0,studyKeys[i]);ArrayRemove(studyKeys,i,1);ArrayRemove(studyTimes,i,1);ArrayRemove(studyPaint,i,1);removed=true;}
 if(removed)StudyReindex();
}
string StudyPrefix(const string name)
{
 // Replacing an indicator can defer old OnDeinit until after new OnInit.
 // A monotonic namespace prevents that old cleanup deleting new drawings.
 string counter="TVST.Instance."+IntegerToString(ChartID());
 if(!GlobalVariableCheck(counter))GlobalVariableSet(counter,0);
 double previous=GlobalVariableGet(counter);
 while(!GlobalVariableSetOnCondition(counter,previous+1,previous))previous=GlobalVariableGet(counter);
 return "TVST_"+name+"_"+IntegerToString((long)(previous+1))+"_";
}
string StudyKey(const string studyNamespace,const string role,const datetime t){return studyNamespace+role+"_"+IntegerToString((long)t);}
int StudyEnsure(const string key,const datetime a,const ENUM_OBJECT type,const double p0,const datetime b=0,const double p1=0)
{
 StudyNew(key,a);int index=StudyIndex(key);if(index<0)return -1;if(studyPaint[index].created)return index;
 studyCacheCommands++;bool created=type==OBJ_TEXT?ObjectCreate(0,key,type,0,a,p0):ObjectCreate(0,key,type,0,a,p0,b,p1);if(!created)return -1;
 studyPaint[index].created=true;studyPaint[index].time[0]=a;studyPaint[index].price[0]=p0;studyPaint[index].pointMask=1;
 if(type!=OBJ_TEXT){studyPaint[index].time[1]=b;studyPaint[index].price[1]=p1;studyPaint[index].pointMask=3;}
 ObjectSetInteger(0,key,OBJPROP_SELECTABLE,false);ObjectSetInteger(0,key,OBJPROP_HIDDEN,true);ObjectSetInteger(0,key,OBJPROP_BACK,true);ObjectSetString(0,key,OBJPROP_TOOLTIP,"\n");studyCacheCommands+=4;
 if(type==OBJ_TEXT){ObjectSetString(0,key,OBJPROP_FONT,"Arial");studyCacheCommands++;}
 if(type==OBJ_RECTANGLE){ObjectSetInteger(0,key,OBJPROP_FILL,true);studyCacheCommands++;}
 if(type==OBJ_TREND){ObjectSetInteger(0,key,OBJPROP_RAY_RIGHT,false);studyCacheCommands++;}
 return index;
}
void StudyText(const string key,const datetime t,const double price,const string text,const color ink,const int size,const ENUM_ANCHOR_POINT anchor)
{
 int i=StudyEnsure(key,t,OBJ_TEXT,price);if(i<0)return;
 StudyMoveCached(i,key,0,t,price);StudySetText(i,key,text);StudySetInt(i,key,OBJPROP_COLOR,ink);StudySetInt(i,key,OBJPROP_FONTSIZE,size);StudySetInt(i,key,OBJPROP_ANCHOR,anchor);StudySetInt(i,key,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
}
void StudyHide(const string key){int i=StudyIndex(key);if(i>=0)StudySetInt(i,key,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);}
void StudyBox(const string key,const datetime a,const datetime b,const double top,const double bottom,const color ink)
{
 int i=StudyEnsure(key,a,OBJ_RECTANGLE,top,b,bottom);if(i<0)return;
 StudyMoveCached(i,key,0,a,top);StudyMoveCached(i,key,1,b,bottom);StudySetInt(i,key,OBJPROP_COLOR,ink);StudySetInt(i,key,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
}
void StudyLine(const string key,const datetime a,const datetime b,const double price,const color ink,const ENUM_LINE_STYLE style=STYLE_DASH,const int width=1)
{
 if(price==EMPTY_VALUE)return;int i=StudyEnsure(key,a,OBJ_TREND,price,b,price);if(i<0)return;
 StudyMoveCached(i,key,0,a,price);StudyMoveCached(i,key,1,b,price);StudySetInt(i,key,OBJPROP_COLOR,ink);StudySetInt(i,key,OBJPROP_STYLE,style);if(width!=1 || (studyPaint[i].intMask&(1<<5))!=0)StudySetInt(i,key,OBJPROP_WIDTH,width);StudySetInt(i,key,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
}
// Sweep only on a new bar/history reset; bounded by retained study history.
void StudyPrune(const string studyNamespace,const datetime oldest)
{
 bool removed=false;for(int i=ArraySize(studyKeys)-1;i>=0;i--)if(StringFind(studyKeys[i],studyNamespace)==0 && studyTimes[i]<oldest){ObjectDelete(0,studyKeys[i]);ArrayRemove(studyKeys,i,1);ArrayRemove(studyTimes,i,1);ArrayRemove(studyPaint,i,1);removed=true;}
 if(removed)StudyReindex();
}
color StudyBlend(const color ink,const double opacity)
{return (color)((int)(((int)ink&255)*opacity+15*(1-opacity))|((int)((((int)ink>>8)&255)*opacity+15*(1-opacity))<<8)|((int)((((int)ink>>16)&255)*opacity+15*(1-opacity))<<16));}
#endif

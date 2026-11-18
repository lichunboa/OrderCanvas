#ifndef TV_STUDY_CLOCK_MQH
#define TV_STUDY_CLOCK_MQH
// IC server follows UTC+2 winter / UTC+3 US DST. Explicit configurable contract.
datetime StudyNthSunday(const int year,const int month,const int nth,const int hour)
{MqlDateTime d;ZeroMemory(d);d.year=year;d.mon=month;d.day=1;d.hour=hour;datetime t=StructToTime(d);TimeToStruct(t,d);return t+((7-d.day_of_week)%7+7*(nth-1))*86400;}
bool StudyUSDST(const datetime utc)
{MqlDateTime d;TimeToStruct(utc,d);return utc>=StudyNthSunday(d.year,3,2,7) && utc<StudyNthSunday(d.year,11,1,6);}
datetime StudyServerUTC(const datetime server,const int winterMinutes,const bool dst)
{datetime utc=server-winterMinutes*60;return utc-(dst && StudyUSDST(utc)?3600:0);}
bool StudyInSession(const datetime utc,const bool futures)
{datetime local=utc+(StudyUSDST(utc)?-4:-5)*3600-(futures?3600:0);MqlDateTime d;TimeToStruct(local,d);int minute=d.hour*60+d.min;return minute>=(futures?510:570) && minute<(futures?915:960);}
#endif

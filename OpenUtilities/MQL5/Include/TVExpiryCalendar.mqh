// SPDX-License-Identifier: MIT
#ifndef TV_EXPIRY_CALENDAR_MQH
#define TV_EXPIRY_CALENDAR_MQH

// The MT5 order-expiration capability mask uses bits 1, 2, 4, 8
// corresponding to time modes 0, 1, 2, 3.
bool TVOrderTimeSupported(const int mode,const long mask)
{
   return mode>=0 && mode<=3 && (mask&(1<<mode))!=0;
}
bool TVOrderTimeNeedsDate(const int mode) { return mode==2 || mode==3; }
int TVMonthDays(const int year,const int month)
{
   if(year<1970 || year>3000 || month<1 || month>12) return 0;
   if(month==2) return year%4==0 && (year%100!=0 || year%400==0)?29:28;
   return month==4 || month==6 || month==9 || month==11?30:31;
}
bool TVExpiryPartsValid(const int year,const int month,const int day,const int hour,const int minute)
{
   return day>=1 && day<=TVMonthDays(year,month) && hour>=0 && hour<24 && minute>=0 && minute<60;
}
#endif

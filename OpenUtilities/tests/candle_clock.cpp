// SPDX-License-Identifier: MIT
#include <string>
#include <cassert>
#include <cstdio>
using string=std::string;
template<typename...Args>string StringFormat(const char* format,Args...args){char s[100];std::snprintf(s,sizeof(s),format,args...);return s;}
#include "../MQL5/Include/TVCandleClockDomain.mqh"
int main(){assert(TVCandleSecondsLeft(1000,1300,1001)==299);assert(TVCandleSecondsLeft(1000,1300,1300)==0);assert(TVCandleSecondsLeft(1000,1300,1600)==0);assert(TVCandleSecondsLeft(1000,1300,999)==-1);assert(TVCandleSecondsLeft(0,300,1)==-1);assert(TVCandleClockText(299)=="04:59");assert(TVCandleClockText(0)=="00:00");assert(TVCandleClockText(-1)=="--:--");assert(TVCandleClockText(3661)=="01:01:01");assert(TVCandleClockText(90061)=="1d 01:01:01");}

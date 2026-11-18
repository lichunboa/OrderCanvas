// SPDX-License-Identifier: MIT
#include <cassert>
#include <iostream>
#include "../MQL5/Include/TVExpiryCalendar.mqh"

int main()
{
  for(int mask=0; mask<16; mask++)
    for(int mode=-1; mode<=4; mode++)
      assert(TVOrderTimeSupported(mode,mask)==(mode>=0 && mode<=3 && (mask&(1<<mode))!=0));

  for(int mode=-1; mode<=5; mode++)
    assert(TVOrderTimeNeedsDate(mode)==(mode==2 || mode==3));

  assert(TVMonthDays(2000,2)==29); // divisible by 400
  assert(TVMonthDays(2100,2)==28); // divisible by 100 but not 400
  assert(TVMonthDays(2024,2)==29);
  assert(TVMonthDays(2026,2)==28);
  assert(TVMonthDays(2026,4)==30);
  assert(TVMonthDays(2026,12)==31);
  assert(TVMonthDays(1969,1)==0);
  assert(TVMonthDays(3001,1)==0);
  assert(TVMonthDays(2026,0)==0);
  assert(TVMonthDays(2026,13)==0);

  assert(TVExpiryPartsValid(2028,2,29,23,59));
  assert(TVExpiryPartsValid(1970,1,1,0,0));
  assert(!TVExpiryPartsValid(2026,2,29,12,0));
  assert(!TVExpiryPartsValid(2026,1,0,12,0));
  assert(!TVExpiryPartsValid(2026,11,31,12,0));
  assert(!TVExpiryPartsValid(2026,10,9,24,0));
  assert(!TVExpiryPartsValid(2026,10,9,-1,0));
  assert(!TVExpiryPartsValid(2026,10,9,12,60));
  assert(!TVExpiryPartsValid(2026,10,9,12,-1));
  assert(!TVExpiryPartsValid(2026,13,1,0,0));
  std::cout<<"PASS: MT5 expiry mode mask, Gregorian month lengths, date/time bounds\n";
}

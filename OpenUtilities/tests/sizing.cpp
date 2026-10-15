// SPDX-License-Identifier: MIT
#include <algorithm>
#include <cassert>
#include <cmath>
#include <iostream>
#define MathIsValidNumber std::isfinite
#define MathFloor std::floor
#define MathMax std::max
double NormalizeDouble(double value,int digits) {
  const double scale=std::pow(10.0,digits);
  return std::round(value*scale)/scale;
}
#include "../MQL5/Include/TicketSizing.mqh"
int main() {
  assert(TicketSizingDigits(.00001)==5);
  assert(TicketSizingDigits(4.28)==2);
  // Exact conversion must retain 0.02 lots despite a two-decimal display.
  assert(TicketBudgetVolume(.02*429.03,429.03,.01,100,.01)==.02);
  assert(TicketBudgetVolume(.01,2,.01,100,.01)==0); // below minimum budget
  assert(TicketBudgetVolume(201,2,.01,100,.01)==0); // above maximum
  assert(TicketBudgetVolume(5,2,.03,100,.02)>=.03);
  assert(TicketBudgetVolume(5,0,.01,100,.01)==0);
  assert(TicketBudgetVolume(NAN,2,.01,100,.01)==0);
  for(int cents=1;cents<10000;cents++) {
    const double budget=cents/100.0;
    const double lots=TicketBudgetVolume(budget,429.03,.01,100,.01);
    assert(lots==0 || (lots>=.01 && lots<=100));
    assert(lots*429.03<=budget+1e-7);
  }
  std::cout << "PASS: exact conversion, min/max, unavailable calculation, 9999 budget bounds\n";
}

// SPDX-License-Identifier: MIT
#include <cassert>
#include <cmath>
#include <algorithm>
#include <iostream>
double MathExp(double v){return std::exp(v);}
double MathMax(double a,double b){return std::max(a,b);}
double MathMin(double a,double b){return std::min(a,b);}
#include "../MQL5/Include/TVPointerPriceMath.mqh"

int main()
{
  assert(std::abs(TVPointerDragPrice(2500.,120,140,.025)-2499.5)<1e-9);
  assert(std::abs(TVPointerDragPrice(2500.,120,120,.025)-2500.)<1e-9);
  assert(std::abs(TVPointerDragPrice(2500.,120,100,.025)-2500.5)<1e-9);
  assert(std::abs(TVPointerVerticalPan(2500.,120,140,.025)-2500.5)<1e-9);
  assert(std::abs(TVPointerVerticalPan(2500.,120,100,.025)-2499.5)<1e-9);
  assert(TVPointerAxisFactor(1.)<1 && TVPointerAxisFactor(-1.)>1);
  assert(std::abs(TVPointerAxisFactor(120.)*TVPointerAxisFactor(-120.)-1.)<1e-12);
  assert(TVPointerAxisFactor(1800.)==TVPointerAxisFactor(1200.));
  assert(TVPointerAxisFactor(-1800.)==TVPointerAxisFactor(-1200.));
  std::cout<<"PASS: pointer price delta, vertical pan, axis scaling and cap\n";
}

// SPDX-License-Identifier: MIT
#include <cassert>
#include <iostream>
#include "../MQL5/Include/TVPointerWheelMath.mqh"

int main()
{
  for(int s=0;s<=5;s++)
  {
    assert(TVPointerZoomScale(s,1)==(s==5?5:s+1));
    assert(TVPointerZoomScale(s,-1)==(s==0?0:s-1));
  }

  int remainder=0;
  assert(TVPointerWheelSteps(remainder,0)==0 && remainder==0);
  for(int i=0;i<11;i++)assert(TVPointerWheelSteps(remainder,10)==0 && remainder==(i+1)*10);
  assert(TVPointerWheelSteps(remainder,10)==1 && remainder==0);
  assert(TVPointerWheelSteps(remainder,300)==2 && remainder==60);
  assert(TVPointerWheelSteps(remainder,60)==1 && remainder==0);
  assert(TVPointerWheelSteps(remainder,90)==0 && remainder==90);
  assert(TVPointerWheelSteps(remainder,-120)==-1 && remainder==0);
  assert(TVPointerWheelSteps(remainder,-250)==-2 && remainder==-10);
  assert(TVPointerWheelSteps(remainder,20)==0 && remainder==20);
  assert(TVPointerWheelSteps(remainder,100)==1 && remainder==0);
  std::cout<<"PASS: zoom bounds, fractional wheel accumulation, reversal and multi-notch deltas\n";
}

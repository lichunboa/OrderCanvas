// SPDX-License-Identifier: MIT
#ifndef TV_POINTER_WHEEL_MATH_MQH
#define TV_POINTER_WHEEL_MATH_MQH

// Clamp a one-step chart zoom adjustment to native scale levels 0..5.
// The caller should supply an existing valid scale and delta of -1 or +1.
int TVPointerZoomScale(const int current,const int direction)
{return current+direction<0?0:(current+direction>5?5:current+direction);}

// Accumulate wheel deltas using 120 units per notch. Fractional deltas are
// preserved; reversing direction discards the opposite-direction remainder.
// The mutable remainder is an input/output accumulator owned by the caller;
// this function does not track pointer focus or any UI capture lifecycle.
int TVPointerWheelSteps(int &remainder,const int delta)
{
 if(delta==0)return 0;
 if((remainder>0 && delta<0) || (remainder<0 && delta>0))remainder=0;
 remainder+=delta;
 int steps=remainder/120;
 remainder-=steps*120;
 return steps;
}

#endif

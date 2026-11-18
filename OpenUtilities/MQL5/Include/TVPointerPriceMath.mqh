// SPDX-License-Identifier: MIT
#ifndef TV_POINTER_PRICE_MATH_MQH
#define TV_POINTER_PRICE_MATH_MQH

// Generic conversion from vertical pointer delta to price delta.
// startY and y are chart pixel positions; pricePerPixel is supplied by caller.
double TVPointerDragPrice(const double startPrice,const int startY,const int y,const double pricePerPixel)
{return startPrice+(startY-y)*pricePerPixel;}

// Scale factor for vertical price-axis gestures, with bounded exponent input.
double TVPointerAxisFactor(const double delta)
{return MathExp(-MathMax(-1200.,MathMin(1200.,delta))*0.001);}

// Translation of vertical pointer movement into price-scale panning.
double TVPointerVerticalPan(const double start,const int startY,const int y,const double pricePerPixel)
{return start+(y-startY)*pricePerPixel;}

#endif

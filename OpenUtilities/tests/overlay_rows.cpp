// SPDX-License-Identifier: MIT
#include <cassert>
#include <iostream>
#include "../MQL5/Include/TVOverlayRowIntervals.mqh"

int main()
{
  assert(TVOverlayRowsOverlap(100,24,110,24));
  assert(TVOverlayRowsOverlap(110,24,100,24));
  assert(TVOverlayRowsOverlap(100,24,100,24));
  assert(TVOverlayRowsOverlap(105,5,0,200));
  assert(TVOverlayRowsOverlap(-10,20,0,3));
  assert(!TVOverlayRowsOverlap(100,24,124,12)); // touching
  assert(!TVOverlayRowsOverlap(124,12,100,24));
  assert(!TVOverlayRowsOverlap(100,24,200,24));
  assert(!TVOverlayRowsOverlap(-100,20,0,24));
  std::cout<<"PASS: positive-height vertical row overlap and boundary conditions\n";
}

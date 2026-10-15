// SPDX-License-Identifier: MIT
#ifndef TV_OVERLAY_ROW_INTERVALS_MQH
#define TV_OVERLAY_ROW_INTERVALS_MQH

// True when two vertically positioned, positive-height rows overlap.
// Touching boundaries are not overlapping.
bool TVOverlayRowsOverlap(const int a,const int ah,const int b,const int bh)
{return a<b+bh && a+ah>b;}

#endif

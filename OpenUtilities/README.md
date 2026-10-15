# OrderCanvas OpenUtilities

[中文](README.zh-CN.md) · [Open-source policy](../docs/OPEN_SOURCE.md)

Small, standalone **MQL5 utility functions**, released under the **MIT License** to help the MetaTrader 5 developer community. They are taken from the OrderCanvas development source; this folder is not the source code of the commercial trading panel.

## Available modules — batches 1, 2 and 3

| Module | What it does | Code | Test |
|---|---|---|---|
| Budget-based lot sizing | Compute volume from a monetary budget and cost per lot, respecting min/max/step; return 0 when no valid volume fits, rather than silently increasing risk | [TicketSizing.mqh](MQL5/Include/TicketSizing.mqh) | [sizing.cpp](tests/sizing.cpp) |
| Candle countdown | Compute the remaining seconds to bar close and format a human-readable countdown; expired bars remain at zero until a new bar appears | [TVCandleClockDomain.mqh](MQL5/Include/TVCandleClockDomain.mqh) | [candle_clock.cpp](tests/candle_clock.cpp) |
| Expiry calendar (batch 2) | Validate Gregorian date/time components and inspect MT5 order-expiration capability bits; no trading/order-submission logic | [TVExpiryCalendar.mqh](MQL5/Include/TVExpiryCalendar.mqh) | [expiry_calendar.cpp](tests/expiry_calendar.cpp) |
| Vertical row overlap (batch 2) | Decide whether two positive-height vertical intervals overlap (touching edges do not overlap); no panel geometry, drag engine or UI rendering source | [TVOverlayRowIntervals.mqh](MQL5/Include/TVOverlayRowIntervals.mqh) | [overlay_rows.cpp](tests/overlay_rows.cpp) |
| Pointer-to-price maths (batch 3) | Map vertical pointer movement to price deltas, panning and bounded exponential axis scaling | [TVPointerPriceMath.mqh](MQL5/Include/TVPointerPriceMath.mqh) | [pointer_price_math.cpp](tests/pointer_price_math.cpp) |
| Wheel zoom maths (batch 3) | Clamp MT5 chart zoom levels and accumulate fractional wheel delta with reversal handling | [TVPointerWheelMath.mqh](MQL5/Include/TVPointerWheelMath.mqh) | [pointer_wheel_math.cpp](tests/pointer_wheel_math.cpp) |

### Using the modules

Copy the desired `.mqh` file into your MQL5 `Include` folder and include it in your own source. For budget sizing, the calling application must calculate the cost per lot using correct broker and symbol data; this utility does **not** calculate tick value, margin, or risk for you. A return value of `0` means no permissible volume was found. For the expiry helper, read the expiration capabilities from the correct MT5 symbol; this helper neither checks current server time nor submits orders. The row-overlap helper expects **positive heights** and does not perform window clipping. The pointer helpers operate on numbers supplied by the caller (including a price-per-pixel coefficient and the current chart zoom level); they do **not** derive broker prices, verify chart focus, listen for mouse events or implement safe order dragging. `TVPointerWheelSteps` mutates its caller-owned integer remainder; reset that accumulator when switching input devices or contexts.

### MQL5 example (does not place trades)

See [BudgetSizingDemo.mq5](examples/BudgetSizingDemo.mq5). Copy `TicketSizing.mqh` into the MT5 data folder's `MQL5/Include`, copy the example to `MQL5/Scripts`, then compile in MetaEditor and run it on a demo chart. It prints a calculated volume using manually supplied sample inputs, without sending any broker request. **Actual MetaEditor compilation of this example remains to be verified.**

### Running tests on macOS / Linux

```sh
c++ -std=c++17 -O2 tests/sizing.cpp -o /tmp/oc-sizing && /tmp/oc-sizing
c++ -std=c++17 -O2 tests/candle_clock.cpp -o /tmp/oc-clock && /tmp/oc-clock
c++ -std=c++17 -O2 tests/expiry_calendar.cpp -o /tmp/oc-expiry && /tmp/oc-expiry
c++ -std=c++17 -O2 tests/overlay_rows.cpp -o /tmp/oc-overlap && /tmp/oc-overlap
c++ -std=c++17 -O2 tests/pointer_price_math.cpp -o /tmp/oc-pointer-price && /tmp/oc-pointer-price
c++ -std=c++17 -O2 tests/pointer_wheel_math.cpp -o /tmp/oc-pointer-wheel && /tmp/oc-pointer-wheel
```

Tests use small host-language adapters to exercise the same pure function bodies; successful host tests do not replace compilation or broker-specific verification in MetaTrader 5.

### Scope and license

Only files **inside this `OpenUtilities/` directory** are licensed under [MIT](LICENSE). The `TVStudySuite/` folder is licensed separately under MPL-2.0; `OrderCanvas.ex5`, the commercial panel and the licensing system remain proprietary. No source code for order execution, UI rendering, pointer capture/gesture state machines, signing secrets, or customer licensing is included here.

This is sample/library code, **not a trading system**, and provides no investment advice or warranty. Use a demo account and independently check broker-specific constraints before incorporating these functions into live trading software.

For provenance, redistribution details, and future candidates see the [open-source policy](../docs/OPEN_SOURCE.md).

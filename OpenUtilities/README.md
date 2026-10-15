# OrderCanvas OpenUtilities

[中文](README.zh-CN.md) · [Open-source policy](../docs/OPEN_SOURCE.md)

Small, standalone **MQL5 utility functions**, released under the **MIT License** to help the MetaTrader 5 developer community. They are taken from the OrderCanvas development source; this folder is not the source code of the commercial trading panel.

## Available modules — batches 1 and 2

| Module | What it does | Code | Test |
|---|---|---|---|
| Budget-based lot sizing | Compute volume from a monetary budget and cost per lot, respecting min/max/step; return 0 when no valid volume fits, rather than silently increasing risk | [TicketSizing.mqh](MQL5/Include/TicketSizing.mqh) | [sizing.cpp](tests/sizing.cpp) |
| Candle countdown | Compute the remaining seconds to bar close and format a human-readable countdown; expired bars remain at zero until a new bar appears | [TVCandleClockDomain.mqh](MQL5/Include/TVCandleClockDomain.mqh) | [candle_clock.cpp](tests/candle_clock.cpp) |
| Expiry calendar (batch 2) | Validate Gregorian date/time components and inspect MT5 order-expiration capability bits; no trading/order-submission logic | [TVExpiryCalendar.mqh](MQL5/Include/TVExpiryCalendar.mqh) | [expiry_calendar.cpp](tests/expiry_calendar.cpp) |
| Vertical row overlap (batch 2) | Decide whether two positive-height vertical intervals overlap (touching edges do not overlap); no panel geometry, drag engine or UI rendering source | [TVOverlayRowIntervals.mqh](MQL5/Include/TVOverlayRowIntervals.mqh) | [overlay_rows.cpp](tests/overlay_rows.cpp) |

### Using the modules

Copy the desired `.mqh` file into your MQL5 `Include` folder and include it in your own source. For budget sizing, the calling application must calculate the cost per lot using correct broker and symbol data; this utility does **not** calculate tick value, margin, or risk for you. A return value of `0` means no permissible volume was found. For the expiry helper, read the expiration capabilities from the correct MT5 symbol; this helper neither checks current server time nor submits orders. The row-overlap helper expects **positive heights** and does not perform window clipping.

### Running tests on macOS / Linux

```sh
c++ -std=c++17 -O2 tests/sizing.cpp -o /tmp/oc-sizing && /tmp/oc-sizing
c++ -std=c++17 -O2 tests/candle_clock.cpp -o /tmp/oc-clock && /tmp/oc-clock
c++ -std=c++17 -O2 tests/expiry_calendar.cpp -o /tmp/oc-expiry && /tmp/oc-expiry
c++ -std=c++17 -O2 tests/overlay_rows.cpp -o /tmp/oc-overlap && /tmp/oc-overlap
```

Tests use small host-language adapters to exercise the same pure function bodies; successful host tests do not replace compilation or broker-specific verification in MetaTrader 5.

### Scope and license

Only files **inside this `OpenUtilities/` directory** are licensed under [MIT](LICENSE). The `TVStudySuite/` folder is licensed separately under MPL-2.0; `OrderCanvas.ex5`, the commercial panel and the licensing system remain proprietary. No source code for order execution, UI rendering, signing secrets, or customer licensing is included here.

This is sample/library code, **not a trading system**, and provides no investment advice or warranty. Use a demo account and independently check broker-specific constraints before incorporating these functions into live trading software.

For provenance, redistribution details, and future candidates see the [open-source policy](../docs/OPEN_SOURCE.md).

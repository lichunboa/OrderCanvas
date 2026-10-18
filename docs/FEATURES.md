# OrderCanvas feature list (1.9)

**English** · [中文](FEATURES.zh-CN.md)

OrderCanvas is a MetaTrader 5 chart-trading panel (an EA, "Utilities" category): order entry, order lines, position management and trade analytics in the style of modern trading platforms, on the MT5 chart. Pure MQL5 - no DLL, no network access - on Windows and macOS.

## What's new in 1.9

| Area | Changes |
|---|---|
| Order lines | Dragging a TP / SL / order line **applies on release** (a review option is available); clicking a line's P/L opens its editor **beside that line**; drag 「半」 out for **staged take profit / staged stop loss** (the tag shows the share and its P/L; sub charts show them too); **compact labels** on sub charts that open on hover |
| Auto protection | Trailing by **ATR, swing low / high or fixed R**, optionally from entry; new **auto partial close at x R**; the three switches sit in the ticket and show their rules |
| Indicators & templates | Six template presets (price action, clean, trend EMAs, Bollinger + RSI, MACD, volume); **TradingView-style** indicators, all 2 px (MACD with signal line and a four-colour histogram), thin dashed price-action EMAs; no tick volume under the candles by default |
| Multi-chart workspace | Sub charts show only symbol and timeframe and may show another symbol; a **band marks the span the trading chart shows**; 「One chart」 / 「Back to MT5」; the order panel has its own pane below the indicators |
| Interface | Warm light theme, clearer on-states, icons by function, the **spread turns red** when unusually wide; **ⓘ help** next to the settings that need it (hover for the calculation) |
| Stability & speed | Order-panel repaint from ~7 ms to ~0.3 ms a frame; fixed money exits on small crypto positions (0 ticks, greyed submit) and line drags on short chart windows |
| Versioning | Two-part version numbers that match the MQL5 Market (1.9, 1.10, ...) |

## 1. Order ticket

| Feature | Details |
|---|---|
| Order types | Market, Limit, Stop, Stop Limit; pending expiry GTC / today / specific time (calendar) |
| Five sizing modes | Lots, margin, % of balance, risk in money, risk in % (lot size from the stop distance); equivalents on the right |
| TP / SL | Each with its own switch; P/L money by default (account currency), or ticks, price, % of price, pips, % of balance; ticks shown alongside; live reward:risk that can be **locked** (change one, the other follows) |
| Errors | An invalid field shows the reason right above it (side, broker minimum distance, money needed for the minimum lot); the chart "!" shows it on hover |
| Colours match the lines | TP caption and amount in green, SL in amber, like their chart lines; Buy blue, Sell red |
| Auto-protection switches | One row under the exits: BE +1R · Trail ATR×2 · Partial 1R·50% (your settings), click to switch, 「Settings ›」 for details |
| One-click trading | Header switch: the Sell / Buy quotes trade at market at once and the bottom button becomes Close all (this symbol) |
| Collapsed ticket | Side, type, size and submit only; order type and size mode as drop-downs |
| Order presets | Type, offset, exits and expiry, up to five (grid icon in the header) |
| Layout | Floating or docked; it **grows downward** when you switch order type (the toolbar stays put); scrolls in short windows |
| Information | Trade value, tick value, required margin (broker data); a blocked order says why on the button |

## 2. Order lines on the chart

| Feature | Details |
|---|---|
| Preview before sending | Choosing a side draws entry / TP / SL draft lines (dashed); nothing is sent until you confirm |
| Drag to modify | Drag entry, TP and SL lines; **applies on release** (TradingView). Settings can switch to a Discard / Confirm review on the line |
| Pull out TP / SL | Press the TP / SL handle on an order line and drag - no click first |
| Position label | `[size | P/L | BE | ½ | Rev | ×]`: break-even (optionally covering commission ×2, swap, an extra offset), partial close, reverse, close; confirmed next to the pointer unless switched off |
| Staged TP / SL | **Drag ½ out**: towards profit a staged take profit, towards loss a staged stop loss; the tag shows the share and the P/L at that price (e.g. TP2 · 25% · +41.50 USD); drag the tag to move it, click it for 25 / 33 / 50 / 67 / 75 / 100 %, × removes it. **Up to 3 of each** per position; shown on every chart (sub charts too), executed by one chart per symbol; kept across restarts |
| Editor beside the line | Click a position's P/L or an order's tag: SL, TP, break-even, quantity (positions: lower = partial close, higher = add; orders: placed again at the same price with the new size), staged levels - right next to the line; the ticket stays usable |
| Price box | At the right end of each line: click to type a price, drag to move the line |
| Compact on sub charts | On a sub chart order lines show size and P/L only; the line under the pointer shows the full label; switchable in Settings |
| Price axis | Every line has its price tag on the axis; the lines of one order are linked |

## 3. Auto protection and risk caps (off by default)

| Feature | Details |
|---|---|
| R | The distance from entry to the stop when the position is first seen with a stop; fixed afterwards and kept across restarts |
| Auto break-even | At +x R (0.5-10 R, custom values allowed) the stop moves to the entry plus the ticked costs; once per position |
| Trailing stop | On each closed bar, only tightening. By **ATR(14) × multiple**, the **low / high of the last N bars** (sells add the spread), or a **fixed multiple × R**; from entry or after break-even |
| Auto partial close | At +x R close y % (of the size at that moment, rounded to the volume step), once per position |
| Economic calendar | MetaTrader's own calendar, shown like TradingView: a small icon per release along the bottom of the chart (orange = high impact); **hover** for its time line and a short card (actual / forecast / previous), **click** for the details and the last 6 releases; a toolbar warning ahead of high-impact releases (15 min by default); the actual value appears about 2 s after MetaQuotes publishes it and stays on the toolbar for 3 minutes (green = good for the currency, red = bad, as MetaQuotes rates it), with revised previous values; optional pause of new positions around them (off by default); GitHub / shop builds also list **official releases** of the matching central bank / statistics office in the details (public RSS, sites to allow once; not in the Market build) |
| Max spread | New positions are refused while this symbol's spread is above the cap (closing / modifying unaffected); the toolbar spread turns red when unusually wide; clicking it opens the setting |
| Max risk per trade | Loss at the stop as % of equity; above the cap the order is not sent |
| Requirements | MT5 and this chart stay open (an EA, not a server-side order); this panel's Magic number only |
| Help | ⓘ next to each related setting, with the calculation and an example on hover |

## 4. Fast actions

| Feature | Details |
|---|---|
| Hotkeys | Typed in Settings, single keys or combinations (B, Shift+S, Ctrl+Shift+X, F2): buy / sell at market, close, break-even, partial close, collapse / expand; a cooldown prevents doubles |
| Follow the pointer | Shift+B / Shift+S: an order follows the pointer and a click places it (Limit or Stop by position); L / P: the stop / target follows the pointer (draft or newest position / order) with the P/L at that price; left click sets, right click or Esc cancels |
| Order-type cycle | Shift+T cycles the ticked types; direct keys for Limit / Stop / Market |
| Toolbar switch | Hotkeys are off until switched on from the toolbar; hover lists every key |

## 5. Workspace and chart

| Feature | Details |
|---|---|
| Toolbar | Settings, symbol search, timeframe, templates, sub charts, order panel, ticket, hotkeys, help; icons by function, icons-only mode, tinted when on |
| Template presets | Price action (factory workbench), clean candles, trend EMAs 20/50/200, Bollinger + RSI, MACD + EMA 20, volume + EMA 20; plus your own templates. A preset replaces only the indicators it added |
| TradingView-style indicators | OC EMA, OC BB, OC RSI (70/50/30), OC MACD (MACD, signal, four-colour histogram), OC Volume (candle-coloured + average), OC ATR - all 2 px and editable / removable like any indicator |
| Sub charts & layouts | Open real MT5 charts of this symbol in any timeframe, 8 layouts (e.g. two small left, large right); sub charts show only symbol and timeframe and may switch symbol; auto scale by default, with free axis, chart shift, autoscroll and back-to-latest in the timeframe menu |
| Trading-chart band | Sub charts shade the time span the trading chart shows (not when the whole sub chart lies inside it) |
| Back to normal | 「One chart」 closes the sub charts; 「Back to MT5」 keeps them in MetaTrader's window (Alt+R tiles) |
| Order panel | Own pane below the indicators: Positions / Orders / History / Account / Analytics; sorting, totals, hover highlights the chart lines, maximise, close all |
| Analytics | Strategy-report style: KPIs, equity and drawdown, profit structure, win / loss, distribution, long vs short, by weekday / holding time / close hour, performance / risk / symbol tables; actual risk per trade (MAE) |
| Chart handling | Wheel zoom, drag pan, free price scale (double-click the scale for auto), the chart follows new bars from where you left it, bar-close countdown |
| Theme | Light (warm), dark, or auto (follows the chart background); sub charts follow the trading chart |
| Spread | Live spread on the toolbar; red with a hint when well above this symbol's usual spread or above the cap |
| Price-action workbench | Built-in open-source **TVStudySuite** (MPL-2.0): EMAs, gaps, inside / outside bars, previous-day levels, bar count, H1/H2/L1/L2 signals |
| Guide | A movable 6-step guide with a small task per step |
| Symbol search | Grouped by category and exchange, favourites, keyboard selection |

## 6. Safety, compatibility and performance

| Feature | Details |
|---|---|
| Account types | Hedging, netting and exchange (netting partial close by an opposite deal) |
| Live accounts | One-time risk confirmation; optional demo-only mode |
| Magic isolation | Manages only its own Magic number; other orders are shown read-only |
| Exact identity | Every modify / close is bound to ticket, account, symbol and Magic; stale clicks are refused |
| Broker is the truth | Order lines are rebuilt from the terminal's positions and orders after every transaction; no shadow state |
| Compatibility | Does not lock other indicators (ATR and others can be edited or removed); independent of other EAs' orders |
| Performance | Canvas redrawn by dirty regions; ~1.3 ms a drag frame; order panel ~0.3 ms a repaint |
| Platforms | Tested on Windows and macOS (Wine); text scales with screen DPI; works in the Strategy Tester (no licence needed) |
| Language | Chinese / English / follow the terminal |
| Licence | Key bound to the MT5 account number, verified offline |

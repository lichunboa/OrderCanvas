<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brand/logo-dark-transparent-6x.png">
  <source media="(prefers-color-scheme: light)" srcset="assets/brand/logo-light-transparent-6x.png">
  <img src="assets/brand/logo-light-transparent-6x.png" alt="OrderCanvas for MT5" width="320">
</picture>

# OrderCanvas

**A modern chart-trading panel for MetaTrader 5**

Preview every order on the chart before it is sent · drag order lines to modify · break-even, partial close and reverse right on the position line · strategy-report analytics · built-in open-source price-action workbench

[![Release](https://img.shields.io/github/v/release/lichunboa/OrderCanvas?label=release)](https://github.com/lichunboa/OrderCanvas/releases/latest)
![Platform](https://img.shields.io/badge/MetaTrader-5-1f6feb)
![OS](https://img.shields.io/badge/Windows%20%7C%20macOS-supported-555)
![No DLL](https://img.shields.io/badge/DLL-none-2ea44f)
[![Workbench](https://img.shields.io/badge/workbench-MPL--2.0-orange)](TVStudySuite)

**English** · [中文](README.zh-CN.md)

[Official website](https://getordercanvas.com/oc/shop?lang=en) · [MQL5 Market](https://www.mql5.com/en/market/product/201771) · [Download](https://github.com/lichunboa/OrderCanvas/releases/latest) · [Install guide](docs/INSTALL.md) · [All features](docs/FEATURES.md) · [Changelog](CHANGELOG.md) · [Telegram](https://t.me/OrderCanvasbot)

</div>

![OrderCanvas](images/panel.png)

## Choose your path

| I want to... | Start here |
|---|---|
| **Trade with OrderCanvas** | [Features](docs/FEATURES.md) · [Installation](docs/INSTALL.md) · [Releases](https://github.com/lichunboa/OrderCanvas/releases) |
| **Reuse open MQL5 code** | [Developer guide](docs/DEVELOPERS.md) · [MIT utilities](OpenUtilities/) · [MPL indicator source](TVStudySuite/) |
| **Contribute or report a bug** | [Repository map](docs/PROJECT_STRUCTURE.md) · [Contributing](CONTRIBUTING.md) · [Issues](https://github.com/lichunboa/OrderCanvas/issues) · [Discussions](https://github.com/lichunboa/OrderCanvas/discussions) · [Security](SECURITY.md) · [Community channels](docs/COMMUNITY.md) |

**Mixed-license repository:** commercial UI and trade execution remain proprietary. [Open-source policy](docs/OPEN_SOURCE.md).

## Open source + commercial product

**What you can build from source:** [OpenUtilities](OpenUtilities/) (MIT: independent MQL5 helpers for lot sizing, candle countdown, expiry dates, row overlap and pointer/wheel maths) and [TVStudySuite](TVStudySuite/) (MPL-2.0: price-action workbench source with original-author attribution). **What remains commercial:** the OrderCanvas chart-trading panel, order-execution/UI internals, and license verification. Publishing these open components does not open-source the commercial EX5 or its licensing system. [Licensing and attribution details](docs/OPEN_SOURCE.md) · [Contributing](CONTRIBUTING.md).

## Quick start

1. **[Download `OrderCanvas.zip`](https://github.com/lichunboa/OrderCanvas/releases/latest)**, unzip it and double-click **`Install.bat`**.
2. Restart MetaTrader 5, drag **OrderCanvas** from the Navigator onto a chart and allow *Algo Trading* - your chart stays as it is; the toolbar *Templates* menu applies our look and studies when you want them.
3. Paste your key into the license card on the chart and click **Activate** - or run everything in the **Strategy Tester without a key** first.

## Why OrderCanvas

MetaTrader 5 is a great execution platform, but placing and managing trades by hand is slow: a dialog for every order, lot sizes worked out on a calculator, protection edited through right-click menus. OrderCanvas moves the whole workflow onto the chart.

| Without | With OrderCanvas |
|---|---|
| A modal dialog for every order; lot size by hand | Pick a side - draft entry / TP / SL lines appear, **lots are sized from the stop distance** |
| Right-click → Modify → type prices | **Drag the order line**; pull a new TP / SL out of any order line |
| Break-even or half close needs mental math | **BE / ½ / Reverse / ×** buttons on the position line |
| Fat-finger orders | **Preview before sending**; confirmations appear next to the cursor |
| P&L analysis means exporting a report | **Analytics tab**: KPI strip, equity + drawdown, P&L distribution, win/loss, long vs short, time-of-day and weekday charts |
| Price-action studies are separate downloads | **Built-in workbench**: gaps, inside/outside bars, previous-day levels, bar count, H1/H2/L1/L2 signals |

Most MT5 trade panels draw draggable lines and size the lot from the stop. OrderCanvas does that too - the differences are in the details that cost money when they go wrong:

- **Nothing is sent until you confirm the preview.** The draft is drawn on the chart first and can be dragged; a click never trades by accident.
- **Every action is bound to the exact order it was created for** (ticket, account, symbol, magic number). If the book changed, the action is rejected instead of hitting another order.
- **Analysis lives where you trade** - a dockable order panel with history and a full strategy-report style analytics page, not an exported HTML report.

## Core features

### 1. Draft preview before sending
Choose Buy or Sell and the order is drawn on the chart first - entry, take-profit and stop-loss as light dashed lines with their quantity, type and expected P&L. Drag any of them, then confirm. Nothing reaches the broker until you do.

<p align="center"><img src="images/chip-draft.png" width="49%"> <img src="images/chip-protection.png" width="49%"></p>

### 2. Draggable order lines and position-line actions
Every position, pending order, TP and SL is a live line you can drag. Drag a TP/SL handle out of an order line to add protection. The position label carries its own actions:

- **BE** - move the stop to break-even, optionally covering commission, swap and a slippage buffer (configurable in ticks)
- **½** - partial close by a preset share (25 / 33 / 50 / 67 / 75 %); **drag it out** of the line for a staged level - towards profit a staged take profit, towards loss a staged stop loss (its tag shows the share and P/L; click it to change the share)
- **Reverse** and **×** close - both confirmed next to the pointer by default

![Order lines](images/orderlines.png)

Dragging a TP, SL or order line applies the new price when you let go (TradingView); a setting turns on a 放弃 / 确认 review instead. Clicking a line's P/L opens its editor right beside the line - SL / TP, quantity, staged levels.

<p align="center"><img src="images/staged-lines.png" width="49%"> <img src="images/line-editor.png" width="40%"></p>

### 3. Professional order ticket
- Market, Limit, Stop and Stop-Limit orders; expiry GTC / today / specific time (with a calendar)
- **Five sizing modes**: lots, margin, % of balance, risk in money, risk in % - the lot size follows the stop distance
- TP / SL as P/L money by default, or in ticks, price, % of price, pips or % of balance; reward:risk shown live
- Trade value, tick value and required margin from the broker, with the account currency
- Up to five saved order presets (type, offset, protection, expiry)

<p align="center"><img src="images/ticket-limit.png" width="38%"> <img src="images/oneclick.png" width="38%"></p>

### 4. One-click trading
Turn on *1-click* in the ticket header: a click on the Sell / Buy quote places the selected order type at once - a market order on the Market tab, a limit / stop order at the ticket's price on the other tabs - and on the Market tab the bottom action becomes *Close all* for this symbol (right-hand screenshot above). With 1-click on, close, cancel, partial close and reverse from the order lines and the order panel act at once, without a confirmation.

### 5. Order panel and trade analytics
A dock under the chart with **Positions, Orders, History, Account and Analytics**. History shows open/close times, holding time, commission, swap and net P&L; hovering a row highlights its lines on the chart. **Analytics** reads like a strategy report: a KPI strip (net P&L, max drawdown, trades, win rate, profit factor, costs), the equity curve with drawdown and a hover card per trade, then chart cards - profit structure, win / loss, P&L distribution, long vs short, by weekday, holding time and close hour - and the performance, risk and per-symbol tables. Today / 7 days / 30 days / all, this symbol or all symbols; maximise the panel to use the whole chart. Each closed trade also shows its **actual risk** - the largest floating loss while it was open (MAE) - next to the risk planned by its stop.

![History](images/history.png)
![Analytics](images/analysis.png)

### 6. Price-action workbench (built in, open source)
OrderCanvas carries **TVStudySuite**, a price-action study workbench drawn natively on the MT5 chart:

- **Moving averages & patterns** - chart EMA and a higher-timeframe EMA, opening / wick / body gaps, OO / II / IOI bars, previous-day high / low / close
- **Bar count** - numbered bars with session filter and special-number colours
- **Entry signals** - H1 / H2 / L1 / L2 second-entry labels with optional bar-close alerts

Each module, colour and size is set in *Settings → page selector*. The workbench is a MetaTrader 5 translation of three open-source TradingView scripts and is published under **MPL-2.0** - full source, license and notices in [`TVStudySuite/`](TVStudySuite). It is also installed as a standalone indicator you can add to any chart.

![Price-action workbench](images/workbench.png)

### 7. Risk caps and auto protection (off by default)
- **Max spread** per symbol and **max risk per trade** (% of equity, from the stop distance): when a cap is exceeded the submit button says why and nothing is sent
- **Auto break-even**: once a position is +0.5R / +1R / +1.5R / +2R in profit, its stop moves to break-even (fees included). R is the stop distance when the position was opened and is remembered across terminal restarts
- **Trailing stop**: on each closed bar the stop follows ATR(14) × k, the low / high of the last N bars, or a fixed k × R, and only ever tightens; it can start at entry or after break-even
- **Auto partial close**: once at +x R, close y % of the position
- The three switches sit in the ticket under the exits, each showing its rule (BE +1R · Trail ATR×2 · Partial 1R·50%); 「Settings ›」 opens the details
- They run while MT5 and this chart stay open (it is an EA, not a server-side stop) and act only on this panel's Magic number

<p align="center"><img src="images/ticket-protect.png" width="38%"></p>

## Feature checklist

Features traders usually compare when choosing an MT5 trade panel, and where OrderCanvas has them:

| Feature | OrderCanvas |
|---|---|
| Lot size from risk % / risk amount / balance % / margin | ✅ ticket, follows the stop distance |
| Drag entry / SL / TP lines; pull new SL / TP out of an order line | ✅ |
| Preview before sending | ✅ draft lines, nothing is sent before you confirm |
| One-click break-even (fees, swap, slippage buffer) | ✅ position line `BE` |
| Auto break-even at a profit multiple | ✅ +0.5R to +2R |
| Trailing stop | ✅ ATR, swing low / high or fixed R; closed bars, tighten only |
| Partial close / staged TP & SL | ✅ 25-100 %, drag ½ out for up to 3 staged TPs and 3 staged SLs; auto partial close at x R |
| One-click trading, close symbol / close all | ✅ |
| Hotkeys, single-key buy / sell, click-to-place orders and stops at the mouse | ✅ typed bindings, follow-the-pointer mode |
| Max spread / max risk per trade | ✅ |
| Pending orders with expiry, order presets | ✅ GTC / day / date, 5 presets |
| Trade history and performance analytics in the chart | ✅ |
| Hedging, netting and exchange accounts | ✅ |
| No DLL, no external service, works in the Strategy Tester | ✅ |

## More

- **Staged take profit / stop loss** - drag ½ out of a position line (profit side = TP, losing side = SL), up to three of each per position, the tag showing the share and its P/L, each closing its share automatically; shown on sub charts too and kept across terminal restarts
- **Hotkeys** - type any key or combination (B, Shift+S, Ctrl+Shift+X, F2): buy / sell at market, close, break-even, partial close, collapse; **follow the pointer** - Shift+B / Shift+S place a Buy / Sell where you click (Limit or Stop by position), Shift+L / Shift+P move the stop loss / take profit with the mouse; Shift+T cycles the order type. A left click places, a right click cancels; only a refused action shows a note. The toolbar switch turns them on / off (off by default)
- **Price box** at the right end of each order line: click to type a price, drag to move the line
- **Second charts and layouts** - the toolbar's second-chart button opens real MT5 charts of this symbol in any timeframe and tiles them in 8 layouts (for example two small charts on the left, the trading chart large on the right); each sub chart shows only its symbol and timeframe, shades the span the trading chart shows and draws compact order lines. *One chart* closes the sub charts, *Back to MT5* keeps them in MT5's window (Alt+R tiles)
- **Templates** - six presets (price action, clean, trend EMAs, Bollinger + RSI, MACD, volume) with TradingView-style 2 px indicators, or your own templates; type a name and press Enter to save one
- **Live spread** next to the toolbar (can be switched off) and a six-step **first-run guide** with a small task per step
- **Symbol search** grouped by category and exchange, favourites, keyboard navigation
- **Chart workflow** - wheel zoom, drag to pan, free vertical scale, candle countdown, light / dark / auto theme (auto follows the chart background), EMA 20 / ATR 14, a visible chart-shift handle on dark grids
- **Interface** in English or Chinese (follows the terminal by default)
- **Accounts** - hedging, netting and exchange accounts (netting partial closes use an opposite deal)

<p align="center"><img src="images/symbols.png" width="60%"></p>

## Under the hood

OrderCanvas is written in pure MQL5 - no DLLs, no external services, no network access.

- **Broker-authoritative state.** Chart lines are rebuilt from the terminal's positions and orders after every trade transaction; the panel never keeps a shadow copy that could drift from what the broker holds.
- **Exact identity for every action.** A modify, close or reverse is bound to the ticket, account, symbol and magic number it was created for; a click that arrives after the book has changed is rejected instead of acting on another order.
- **Only its own orders.** By default the panel manages orders with its own magic number and leaves other EAs and manual trades alone.
- **Fast rendering.** The ticket is drawn on a Canvas with dirty-region scheduling; order-line labels are rounded Canvas skins over native click targets. Measured on the EA side: about 1.3 ms per drag frame and 0.5 ms per hover.
- **DPI-aware.** Text and layout scale with the screen DPI and the interface font is chosen per platform (Microsoft YaHei UI on Windows, PingFang on macOS), so the panel looks the same on a 96-DPI Windows desktop and a Retina Mac.
- **Safety defaults.** Live accounts show a one-time risk confirmation; close and reverse confirm by default.
- **Tested.** Unit and contract tests for the domain logic, plus Strategy Tester runs on Windows and macOS across gold, FX, indices and crypto with every tick model - including visual mode.

## Download

**[⬇ Download the latest release (OrderCanvas.zip)](https://github.com/lichunboa/OrderCanvas/releases/latest)** · [All versions](https://github.com/lichunboa/OrderCanvas/releases)

The package contains the program, the recommended chart template, the TVStudySuite workbench (compiled + MPL-2.0 source) and a one-click Windows installer. It runs in the Strategy Tester without a key; on a live or demo chart it needs a license key (free 7-day trial available). Every earlier version stays available under [Releases](https://github.com/lichunboa/OrderCanvas/releases).

## Install

Download `OrderCanvas.zip`, unzip it and double-click **`Install.bat`** (Windows) or run `Install-Mac.command` from Terminal (Mac) - it installs the program and the recommended chart template into every MetaTrader 5 on the PC. Restart MT5, right-click a chart → *Templates* → **OrderCanvas**, then paste your key into the license card on the chart and click **Activate** (or F7 → *Inputs* → `LicenseKey`). The toolbar then shows the days left and the end date.
macOS / manual install and screenshots of each step: [docs/INSTALL.md](docs/INSTALL.md).

## License & pricing

| Plan | Price | Accounts |
|---|---|---|
| Free trial | 0 · 7 days | 1 |
| Monthly | 19 USDT | 2 |
| Yearly | 69 USDT | 2 |
| Lifetime | 89 USDT | 2, including updates |

For a separately licensed copy, visit the [official website](https://getordercanvas.com/oc/shop?lang=en) or Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot). Payment is USDT (TRC20); every order has unique cents (e.g. 19.37) so the payment is matched and the key delivered automatically. Keys are bound to the MT5 account number and verified offline. The **Strategy Tester runs every feature without a key** - try it before you buy. Invite a friend and get 15 days for every paid referral.

## FAQ

**Does it work on macOS?** Yes - MetaTrader 5 for Mac (Wine) and Windows are both tested; layout and fonts adapt to the screen DPI.

**Will it touch my other EAs or manual trades?** No. By default it manages only orders with its own magic number; other positions are shown read-only.

**Hedging or netting?** Both, plus exchange accounts. Partial closes on netting accounts use an opposite deal.

**Can I try it first?** Yes - every feature runs in the Strategy Tester without a key, and there is a free 7-day key for a live/demo account.

**Does it trade by itself?** No. It is a manual trading and analysis tool: no signals, no automated entries. Staged take-profits and break-even run only when you set them.

**Do keys survive updates?** Yes. Keys are bound to your MT5 account number, not to a version; install a new release over the old one.

## Risk notice

Trading foreign exchange, metals and CFDs on margin carries a high level of risk and may not be suitable for all investors. OrderCanvas is a trading tool; it provides no signals and no investment advice. Practise on a demo account first.

OrderCanvas is an independent product and is not affiliated with or endorsed by MetaQuotes or TradingView.

© 2026 OrderCanvas. All rights reserved. See [LICENSE](LICENSE). The TVStudySuite workbench is licensed separately under MPL-2.0 ([TVStudySuite/](TVStudySuite)).

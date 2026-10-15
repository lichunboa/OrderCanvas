# Changelog

## 1.0.6 — 2026-10-15
- **Follow the pointer (hotkeys)**: `Shift+B` / `Shift+S` - a Buy / Sell order follows the mouse (Limit on the favourable side of the price, Stop beyond) and a click on the chart places it with the ticket's size and exits. `Shift+L` / `Shift+P` - the stop loss / take profit follows the mouse; with no draft they act on the newest position or pending order of this symbol and Magic, and the click modifies it. `Shift+E` moves the draft entry. Esc or the same key cancels; nothing is sent before the click.
- **Order type cycle**: `Shift+T` steps through the order types ticked in Settings → Hotkeys (Market / Limit / Stop by default; Stop Limit optional). `Ctrl+Alt+L / P / M` still pick one directly.
- **Price box on order lines**: click it to type a price (Enter applies, Esc cancels); press and drag it to move the line - dragging no longer activates an input box. Live orders go through the same review card as a drag.
- **Hotkeys switch in the toolbar**: 「快捷键 开 / 关」 sits in the toolbar strip next to 「交易面板」; its tooltip lists every binding.
- **Ticket on the left**: the docked ticket opens at the top-left under the toolbar, so the latest bars and the price scale stay visible (drag it anywhere; double-click the header to dock it again).
- **Signal alerts no longer pop up a window**: workbench alerts (patterns, H1/H2/L1/L2) appear as a small note in the chart's top-right corner with the alert sound; license reminders show in the toolbar badge instead of a popup.
- **Settings dialog**: centred on the chart and movable by its title; larger, higher-contrast text.
- Language: switching between Auto / 中文 / English in the settings now takes effect at once.
- One EMA on the chart: the plain MA(20) is removed when the workbench draws its (blue) chart EMA.
- Previous-day high/low lines are off by default (also once for existing settings); turn them on in Settings → General.
- Hotkeys from versions before 1.0.4 that were saved as "none" now get the current defaults once.

## 1.0.5 — 2026-10-15
- **Auto protection (off by default, Settings → Trading)**: auto break-even when a position reaches +0.5R / +1R / +1.5R / +2R (fees included; R = the stop distance at opening, kept across terminal restarts), then optional **ATR trailing** on closed bars (ATR(14) × 1.0-3.0, tighten only). Only positions with this panel's Magic number.
- **Risk caps (off by default)**: max spread per symbol (ticks) and max risk per trade (% of equity). When a cap is exceeded the submit button explains why and nothing is sent. The submit button also shows the trade's risk in money and %.
- **More hotkeys**: set the draft entry / SL / TP at the mouse price (`Shift+E` / `Shift+S` / `Shift+P`) and switch the ticket to limit / stop / market (`Ctrl+Alt+L` / `P` / `M`). Every press shows a short receipt on the chart (done, or why not). Hotkey bindings now apply to every chart of the terminal.
- First start opens a Market **Buy draft** so the ticket is ready to use.
- If MT5's **Algo Trading** is off, the submit button says so (and how to turn it on) instead of failing silently.
- License days are counted on calendar days (UTC) everywhere - the panel, the shop page and the bot show the same number.
- Fixed: settings drop-down lists open next to their field when the page is scrolled.

## 1.0.4 — 2026-10-15
- **Price-action workbench built in**: the TVStudySuite modules (moving averages & patterns, bar count, entry signals) now ship with OrderCanvas on every build, with their settings pages under *Settings → page selector*. The workbench is open source (MPL-2.0); its full source, license and notices are in the package (`TVStudySuite-source`) and in this repository (`TVStudySuite/`).
- **Analytics redesigned** in a strategy-report style: KPI strip, larger equity + drawdown chart with axes and a hover card per trade, and chart cards - profit structure, win / loss donut, P&L distribution, long vs short, by weekday, holding time and close hour - followed by the performance / risk / symbol tables.
- **Hotkeys are typed**: enter `B`, `Shift+S`, `Ctrl+Shift+X`, `F2`... Single letters are allowed. Defaults: Buy `B`, Sell `S`, Close `X`, Break-even `E`, Partial close `H`, Collapse ticket `T`; hotkeys are **off by default** (Panel settings → Hotkeys). Works with Chinese / Japanese / Korean input methods active. A single-letter binding turns off MetaTrader's type-to-switch-symbol box on that chart.
- **Panel settings**: the page selector is a real button next to the title (all builds).
- **License card**: an expired / other-account key keeps showing why it was refused; the toolbar shows the days left as whole days with the end date (a 30-day key shows 30).
- Fixed: after closing the ticket with ×, 「交易面板 / Ticket」 could not reopen it.
- Fixed (macOS): the order panel again reaches the price scale.
- The chart-shift handle (the small triangle at the top of the chart) stays visible with a dark grid.
- License badge moved into the toolbar row (the ticket no longer hides it).
- One version everywhere: EA properties, panel, license card and the indicator show 1.0.4 / 1.04.
- Template follows the author's current chart (zoom, tick volume, right margin, ATR pane height). Installer README: activate in the license card.

## 1.0.3 — 2026-10-15
- **Activate in the chart**: paste the key into the license card and click Activate - no F7 needed. The account number can be selected and copied; the top-right corner shows the days left (or "lifetime").
- **Analytics** is one scrolling page: overview, equity curve, metrics, risk and groups with larger rows.
- **Panel settings** split into General / Trading / Hotkeys; **hotkeys are recorded** - click the field and press the combination (Ctrl+Shift+letter works best).
- Open lists and menus close when you click elsewhere; buttons and rows share one hover highlight.
- Version shown in the panel settings and the license card (EA properties show 1.03).
- Installer: detects portable MetaTrader 5, reports each terminal, writes `install-log.txt`, and explains when the zip was not extracted. Template updated (no volume bars, chart zoom as on the author's chart).
- macOS: the order panel stops at the price scale.

## 1.0.2 — 2026-10-14
- Order panel: **maximise / restore** (header button or double-click); maximised Analytics shows overview, equity curve, metrics, risk and groups on one screen. The ticket steps aside while maximised and otherwise stays above the open panel instead of covering it.
- Hiding the order ticket keeps the order panel and the toolbar; the extra "Order" button is gone (reopen with 「交易面板 / Ticket」).
- 「全部品种 / All symbols」: counts and **close all** now cover every symbol (this panel's Magic only) and ask for a second click to confirm.
- ATR pane is no longer locked: drag its separator, or delete it and it stays deleted on that chart. The template now ships the ATR pane at a quarter height.
- Windows: trading-settings menu no longer clips its text; new input `UiTextSizePercent` (80–125 %); small captions in the order panel are larger.
- Installer: `install.ps1 -Target <folder>` for a portable MT5.

## 1.0.1 — 2026-10-14
- Windows: the panel, toolbar and fonts now keep the same proportions as on a Retina Mac (layout in DPI-independent units) - no more oversized panel on 100 % / 125 % displays.
- Order panel spans the full chart width; when collapsed its header still shows the tabs and balance / equity / floating P&L / free margin.
- The order ticket stops above the order panel header, so the submit button is never covered.
- Crisp vector arrows in the order panel (some Windows fonts lacked the glyphs).

## 1.0.0 — 2026-10
- First release: chart trading ticket (market / limit / stop / stop-limit), draft preview before sending,
  draggable order lines, position-line break-even / partial close / reverse / close, one-click trading,
  staged take-profit, order panel with trade analytics, symbol search, hotkeys, Chinese / English UI.
- Rounded order-line labels, unified fonts, automatic interface font (Windows / Mac), DPI-aware text.
- Offline license keys bound to the MT5 account; free in the Strategy Tester.

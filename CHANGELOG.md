# Changelog

## 1.12.2 — 2026-10-23
- **New-version notice**: when a newer version is out, the toolbar shows "New version x.y.z"; click it for what's new and how to update. Checked at most once a day on the online-activation site (`https://getordercanvas.com`, nothing extra to allow); only the version record is read - no license key or account is sent. No pop-up, no effect on trading, and nothing is shown if the check fails.
- **Sessions and economic events in one row**: the Asia / Europe / US markers and the economic-event icons along the chart bottom now share one row to save space; markers that would meet step aside, and both keep their hover text.
- **Market holidays**: on the main Tokyo, London and New York holidays (Christmas, New Year's Day, Thanksgiving, Japan's Golden Week...) the row shows "H" (休) for that market, with no open / close markers and no 5-minute reminder that day. Holidays are calculated by rule for every year.

## 1.12.1 — 2026-10-23
- **Windows installer**: the package now has `OrderCanvas-Installer.exe`. It lists the MetaTrader 5 terminals on the PC (running ones in bold, those with OrderCanvas already ticked); tick and click Install, and each terminal shows its result and the next steps. Portable terminals are listed too (or add one with "Add MT5 folder…"). It only copies the program and template - no PowerShell, MT5 is not closed and no setting is changed. `Install.bat` stays for PCs whose security software blocks the EXE.
- **Session and economic-event markers**: an outline with text in the same colour on the chart background instead of a coloured fill; volume bars and grid lines no longer cross the text.

## 1.12 — 2026-10-22
- **Online activation**: allow `https://getordercanvas.com` in MetaTrader's WebRequest list and click *Online activation* on the license card - no key to copy. The offline activation key still works without any network. Expiry follows the broker's server date; after it, new positions are blocked while existing positions and orders stay manageable until they are closed.
- **Much smoother on a new installation**: nothing in the panel waits for MetaTrader's downloads any more. The economic calendar, the order panel's analysis and timeframe switches used to freeze the panel while history or calendar data arrived (3-25 s after installing, up to 2 minutes when first opening D1 / H4); they now load in the background.
- **MetaTrader's own dialogs stay open**: adding an indicator no longer closes the indicator or chart-properties dialog; the order panel moves back to the bottom with your next click on the chart.
- **Economic events**: MetaTrader's calendar, high + moderate impact by default, from 14 days back to 90 days ahead (moderate within 30 days); meetings and speeches are square icons. Official central-bank / statistics headlines load only when you open an event's details.
- **Trading sessions**: Asia / Europe / US opens and closes along the chart bottom (Tokyo 09:00-18:00, London and New York 08:00-17:00 local time, daylight saving included) and a toolbar reminder 5 minutes before. Settings → Trading → Economic events.
- **Sub charts**: order lines no longer turn blank after a theme or timeframe change; the onboarding guide shows on the trading chart only.
- **Diagnostics**: Settings → General → Diagnostics → *Send* sends the log straight to us (no passwords, positions or prices); after a severe freeze it is sent automatically (switchable there).
- Chart hints sit at the top right instead of over the ticket and stay readable with a light panel on a dark chart (so do the spread and license days); the drawing hover hint is gone. The package installs a single `OrderCanvas.ex5`; install notes are four short steps.

## 1.10 — 2026-10-19
- **Your chart stays yours**: a new installation adds only the ticket and order lines - no recolouring, no ATR / EMA, no workbench. OrderCanvas's look and studies are one click away in the toolbar's *Templates* menu (the guide shows it). Upgrades keep the chart as it was. Install: drag OrderCanvas from the Navigator onto a chart.
- **Faster, lighter**: a timeframe switch no longer reads every chart object and keeps the workbench it already has (one calculation instead of two) - on a Mac 0.2-1 s instead of 2-7 s; sub charts open without the main chart's objects; per-second work cut (order panel, pane captions, text measuring, chart-shift marker), so MetaTrader's own windows drag more smoothly under Wine.
- **One-click** places the selected order type: market on the Market tab, limit / stop at the ticket's price on the other tabs; *Close all* is the bottom action on the Market tab only.
- **Hotkeys with several orders**: L / P act on the order nearest the pointer; its line is drawn thick and the floating text names it. Hotkeys also work while a drawing is selected.
- **Position / order editor**: Confirm stays grey until something changes; a click on the empty chart closes an unchanged editor; Discard and Confirm share one row.
- **Bar count per timeframe**: on M5 only by default; Settings → Bar count → Visibility picks the timeframes.
- **Drawings**: inside a Fibonacci or channel the chart pans (only its lines and handles move it); a press near a selected drawing's handle never moves the chart as well.
- **Order lines**: a label stacked away from its line has a thin leader to it; labels re-align after the price scale is dragged; 2 px lines in the light theme.
- **Reward:risk** always shown (lock visible and unlockable, rounded box); the field side text sits level with the values; only 「Settings ›」 opens the auto-protection settings.
- Signal alerts follow the chart theme with a colour bar (buy / sell / gap); the bar countdown ticks every second; the 锁定 label no longer stays on the chart with the ticket collapsed; the price-action badges no longer cover the ticket after a restart.

## 1.9 — 2026-10-17
- **Leaner ticket**: no section titles; take profit / stop loss are always shown, and the rarely used rows (time in force, required margin) sit behind one small arrow at the bottom, closed by default. Only 「Settings ›」 opens the auto-protection settings, and that row has more room above the button.
- **Reward:risk always shown**: the row stays in place before a side is picked, so a locked ratio stays visible and can be unlocked; switching TP or SL off releases the lock. The ratio box is rounded and turns blue while locked; the grey tick / USD text sits level with the field values.
- **Sub charts open faster**: the template no longer carries the trading chart's ~460 panel and study objects, so the new chart starts clean (no drawings of the old timeframe for a second).
- **Onboarding guide refreshed** for this release (typed ratio, error reasons above the fields, auto-protection switches, the price-box editor with size, the default keys incl. L / P, EMA 20 / 200, larger pane legends).
- **Version numbers match the MQL5 Market**: from this release the version has two parts (1.9, 1.10, …), the same number the Market shows.
- **Multi-chart layouts rebuilt**: the layout area is measured on a freshly opened chart, so layouts fill MetaTrader's chart area instead of coming out small; the trading chart takes 68 % in the "large + small" layouts. Leftover 副图 close instead of piling up behind the layout. After resizing MetaTrader, press 「原生停靠」 and pick the layout again.
- **Order panel below the indicators**: positions, orders, history, account and analysis now sit in their own pane under ATR instead of covering the bottom of the price chart.
- **Sub charts are minimal**: a chart opened by 「副图」 or a layout shows its symbol and one timeframe button only - no order panel, no badges - at the normal toolbar size, and may show another symbol. While a layout floats, the trading chart gets the same button: it opens M1 … MN plus chart shift, MetaTrader autoscroll and "back to the newest bar", because MetaTrader's own buttons do not work for floating windows.
- **Follow the pointer**: moving the stop loss / take profit of a position or order shows the P/L at the pointer.
- **Take profit / stop loss default to P/L** in the account currency, with ticks as the equivalent on the right. A ticket still on the old tick default switches once; order presets keep the unit you chose.
- **Ticket header**: the ··· menu is replaced by a gear that opens Settings → Trading, which now holds the order-line display switches (positions and orders on the chart, draft lines for market orders, P/L amounts on the lines). The grid icon still opens the order presets.
- **Collapsed ticket**: order type and size mode open a drop-down list instead of cycling on each click.
- **Template presets**: the 模板 menu offers six starting points - price action (the default workbench), clean chart, trend EMAs 20/50/200, Bollinger + RSI, MACD and volume. They use MetaTrader's own indicators, which stay editable and deletable.
- **Sub charts show where the trading chart is**: a shaded band marks the trading chart's visible time range on the other charts; sub charts start on auto scale, with a free-axis switch in the timeframe menu.
- **Stronger colours**: warmer, more contrasted light theme, clearer on-states for switches, coloured Sell / Buy before a side is chosen, a darker chart grid, a finer spread capsule between the quotes.
- **Spread warning**: the toolbar spread turns red when it is well above this symbol's usual spread (or above your cap); clicking it opens the spread-cap setting. Nothing is blocked unless you set a cap.
- **TP / SL straight from the line**: press the TP or SL handle on an order line and drag - no click first.
- **Staged take profit and stop loss**: drag 「半」 (partial close) out of a position line - towards profit for a take-profit level, towards loss for a stop-loss level - for the configured share; click a level's tag to change its share (25 … 100 %). A plain click on 「半」 still closes the share at once.
- **Position editor beside its line**: clicking a position's P/L (or an order's tag) opens the editor right under that line; the ticket stays usable.
- **Auto protection**: the trailing stop can follow ATR(14), the low / high of the last N bars, or a fixed multiple of R, and can start at entry instead of after break-even; an optional auto partial close takes a share off once at +x R.
- **Dragging a line applies on release**, like TradingView: no editor pops up (a setting brings back a 放弃 / 确认 review on the line). Clicking a line's P/L opens its editor beside the line.
- **TradingView-style preset indicators**: MACD with signal line and a four-colour histogram, RSI 70/50/30, Bollinger Bands, candle-coloured volume, EMAs and ATR - all 2 px; the price-action EMAs stay thin and dashed. Tick volume no longer shows under the candles unless you pick the volume preset.
- **Auto protection in the ticket**: under the exits, 保本 / 追踪 / 分批 switches showing their rules, with 「设置 ›」 for the details.
- **Toolbar icons by function** (ticket, order panel, templates, charts, hotkeys, help); 「还原单图」 closes the extra charts, 「放回 MT5 窗口」 keeps them.
- **Ticket**: grows downward when you switch order type (the toolbar stays in place), a closer submit button, TP / SL captions in the colours of their lines.
- Faster order panel: its window place is read once a second instead of on every repaint.
- Fixed: TP / SL in money on a small crypto position (BTC 0.01 lot) showed 0 ticks and greyed out the submit button; a line drag on a short chart window was not applied.
- **Compact order lines on sub charts**: size and P/L only; the line under the pointer opens into the full label (switchable in Settings → Trading).
- **ⓘ help in Settings** for auto protection, break-even costs, partial close, risk caps and the order-line options: hover for the calculation and an example.
- The factory template no longer shows tick volume and draws ATR 2 px, so a new installation looks the same everywhere.
- **Economic calendar** (MetaTrader's own), TradingView style: a small icon per release along the bottom of the chart - hover for its time line and a short card (actual / forecast / previous), click for the details and the latest releases. The toolbar warns ahead of a high-impact release and shows the actual value for 3 minutes after it; an optional pause of new positions around releases (off by default).
- Sub charts follow a template or preset applied on the trading chart; indicator panes keep a sensible height (the weights are rewritten, separators stay draggable).
- Staged levels can be dragged again after they are placed; the Settings help opens as a readable card.
- A first install on a 0.01-tick crypto symbol starts with exits of at least 0.1 % of the price (they were inside the broker's stop level).
- Fixed (license card, English): the hints and the "key not valid" message were cut off.
- **Staged levels**: the tag shows the share and what the level books (TP2 · 25% · +41.50 USD) instead of the lots twice; up to 3 staged take profits **and** 3 staged stop losses per position; the levels show on sub charts too, and only one chart per symbol executes them (no double closes with several charts open).
- Thin dashed price-action EMAs again by default. A dashed or dotted style sets the width to 1 (MetaTrader draws wider lines solid), a wider line switches to solid - with an ⓘ note.
- Fixed: a line style picked in Settings was switched back by the value in the width field; a dialog frame could stay on the chart as an empty box; bar counts and H1 / L1 badges could cover the ticket; 「还原单图」 could leave one sub chart open.
- **Fixed a freeze of MetaTrader on the Mac** when workbench settings (e.g. the EMA style) were applied: the study suite read the chart colour while the panel replaced it, and the two waited on each other. The panel now hands the colour over.
- Calendar: MetaQuotes' own verdict on each release (good / bad for the currency) colours the actual value, a revised previous value is shown, and a new actual value appears within about 2 seconds of MetaQuotes publishing it.
- **Installers**: Windows `Install.bat` no longer uses PowerShell (security software blocked or redirected it) and explains an un-extracted zip, a missing MT5 and a portable MT5 (drag its folder onto it); new `Install-Mac.command` for MetaTrader 5 for Mac, broker Mac apps and CrossOver; package file names are plain ASCII.
- **Official releases (GitHub / shop builds only)**: a calendar icon's details list the latest release titles of the matching central bank or statistics office (Fed, BEA, Census, ECB, BoE, BoJ, BoC, SNB, RBNZ) - their public RSS only: free, long-lived, no account. Allow the sites the card lists once under Tools → Options → Expert Advisors. The MQL5 Market build contains no network code.
- **Lockable reward:risk**: click 「Lock」 beside Risk/Reward; then changing the TP or the SL (typed, dragged, or with L / P) sets the other by the ratio. The ratio itself can be typed (2 or 1:2): the take profit is set from the stop distance, and with the lock on it becomes the locked ratio.
- **Larger pane legends**: ATR, RSI, MACD and Volume panes show their name and current value in the ticket font, values in their line colours (over MetaTrader's small caption). A lower pane that comes back at MetaTrader's default half height after a restart is made small again.
- **Order editor**: Confirm right after typing a size is no longer taken as Discard; Confirm with nothing changed just closes; buttons light up under the pointer.
- **Cancelling a pointer-follow restores the draft**: a right-click or Esc during Shift+E / Shift+B / Shift+S / L / P puts the entry and exits back.
- The official-news sites must be added by hand (MetaTrader keeps the allowed list encrypted; no program can write it): Settings → Trading lists the ones for the chart, the package README lists them per currency.
- **Change a pending order's size**: in the order editor, a new quantity places the order again at the same price, TP / SL and expiry (MetaTrader cannot change an order's volume); if the new size is refused the original comes back.
- **Errors say why**: an invalid field shows its reason above it (e.g. "A buy limit goes below the price; to buy a breakout use Stop", "Too small: the minimum 0.01 lots needs 8.17 USD at this stop"), so does the "!" on the chart; rejected modifications are explained in plain words and stay up for less time.
- **Follow-the-pointer TP / SL**: P (target) clicked on the other side of the entry sets the stop, L the other way round; the hint is just "Stop loss 81,623 · -1.18 USD" and MetaTrader's object tooltip is gone.
- EMA defaults: EMA 20 and EMA 200 of the chart, all thin dashed; the preset EMAs are dashed too.
- Signal alerts are short and translated: "Down body gap · BTCUSD M5 · 07:35".
- Fixed: with the ticket hidden, calendar icons and staged tags did not react to clicks; Shift+E no longer turns a limit into a stop by itself.

## 1.0.8 — 2026-10-17
- **Second charts and multi-chart layouts**: the toolbar 「副图」 button opens real MetaTrader charts of this symbol (any timeframe, from this chart's template, order panel hidden) and arranges them in 8 layouts, including two on the left with this chart large on the right. 「原生停靠」 docks every chart back so MetaTrader's own Window → Tile (Alt+R) works; other OrderCanvas charts can follow this chart's symbol.
- **Templates in the toolbar**: 「模板」 lists the factory OrderCanvas preset and your own templates - apply, replace, rename, remove; type a name and press Enter to save.
- **Light theme and Auto**: one palette for the whole panel; Auto follows the chart background. Drawing colours that MetaTrader picks for dark charts switch to darker twins on a light chart.
- **First-run guide**: six short steps, each with a try-it task, next to the ticket; reopen it from the toolbar.
- **Actual risk per trade**: history and analytics show the largest floating loss of each trade (MAE) next to the planned stop risk, plus initial-stop risk, R statistics, trades without a stop and commission / swap totals. Positions show P&L at stop, R and distance to price; the account tab shows exposure, open-stop risk and a 30-day daily P&L chart.
- **Live spread** after the toolbar (Settings, on by default).
- **Custom values**: numeric trading settings offer 「自定义…」 to type any number.
- **One-click trading** (or 「不再确认」) now also closes, cancels, partially closes and reverses at once from order lines and the order panel, with no confirmation dialog.
- **Follow the pointer**: left click places, right click cancels (MetaTrader's chart menu stays closed); a cancel gives the ticket back its side and order type and clears the draft lines. Esc works with a Chinese input method. Success messages are gone - the line is the feedback; failures still show.
- The chart follows new bars from where you left it (TradingView); a » button returns to the newest bar. Double-click on the price scale = auto scale.
- The toolbar is folded to icons by default; the license badge is short (days left, details in the tooltip).
- Faster: idle CPU use dropped from about 30 % to about 2 % in our tests (an object-cache overflow made every redraw synchronous); the 历史 tab no longer freezes while MetaTrader downloads tick history.
- Fixed: switching timeframe could leave a black chart or scroll into the empty future.
- Fixed: analytics % was meaningless for an account funded inside the selected range.
- Fixed: confirmation dialogs could appear under order chips, and their frame could lag behind the text.
- Fixed (light theme): the collapsed ticket's captions were white on white.
- MQL5 Market build: English-only input captions, as the Market requires.

## 1.0.7 — 2026-10-15
- **Sharper text**: the ticket, the order panel (positions, orders, history, account, analytics), the settings dialog, the symbol search and the hotkey notes now draw their text with Windows' own ClearType renderer. The canvas renderer MetaTrader gives programs only does grey, unhinted smoothing, which is why small Chinese text looked soft; small text is also a little larger.
- **Saving settings is fast again**: on macOS (Wine) a save could take ~10 s on a chart with many workbench drawings; it no longer scans every chart object (≈20 ms).
- Fixed: after a terminal restart the chart could open at the oldest loaded bar instead of the latest one. The chart now follows new bars while the newest bar is in view - also after you drag back to the present, as on TradingView.
- Order panel: text columns no longer touch the number column before them.

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

# Changelog

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

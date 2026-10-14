# OrderCanvas — feature list

**English** · [中文](FEATURES.zh-CN.md)

OrderCanvas is a chart-trading panel for MetaTrader 5 (an Expert Advisor in the *Utilities* category): order entry, order lines and position management in the style of modern trading platforms, directly on the MT5 chart.

## 1. Order ticket

| Feature | Details |
|---|---|
| Order types | Market, Limit, Stop, Stop-Limit; pending expiry GTC / today / specific time (calendar) |
| Five sizing modes | Lots, margin, % of balance, risk in money, risk in % (lots derived from the stop distance); equivalent value shown alongside |
| Take-profit / stop-loss | Independently switchable; in ticks, price, % of price, pips, money or % of balance; reward:risk shown |
| Broker data | Trade value, tick value, required margin with the account currency |
| One-click trading | Header toggle; quotes become instant market buttons and the bottom action becomes *Close all · N* |
| Compact mode | Normal: side, type, size, submit. One-click: large live quotes, size, close all |
| Presets | Type, price offset, protection and expiry - up to five |
| Layout | Draggable, floating or docked, 360–715 px responsive width, scrolls on short windows |

## 2. Order lines on the chart

| Feature | Details |
|---|---|
| Draft preview | Entry / TP / SL drawn as light dashed draft lines first; sent only after confirmation |
| Drag to modify | Drag entry, TP and SL lines - also by dragging the label - before and after sending |
| Pull out protection | Drag a new TP / SL out of an order line's TP / SL handle |
| Connectors | Lines of one order are linked; hovering highlights the group |
| Draft vs live style | Drafts dotted and light, working orders / positions solid |
| Position-line actions | `[size | P&L | BE | ½ | Reverse | ×]`: break-even (commission, swap, slippage buffer), partial close 25/33/50/67/75 %, reverse, close |
| Confirmations | Close / partial / reverse confirm by default, right next to the pointer; can be turned off |
| Price-axis markers | Every order line has a price tag next to the axis |

## 3. Position and order management

| Feature | Details |
|---|---|
| In-panel editing | Click an order line to edit SL, TP, break-even and quantity (less = partial close, more = add with the same protection) |
| Staged take-profit | Up to 3 extra TP levels per position with their own share; executed by the EA, kept across restarts, shown as dashed lines with × |
| Order panel | Positions / Orders / History / Account / Analytics; sort by symbol, time, P&L; totals; history today / 7 / 30 days; resizable, **maximise** with the header button or a double-click (Analytics then shows overview, curve, metrics, risk and groups on one screen); collapsed header keeps balance / equity / floating / free margin; stays when the ticket is hidden; close all for this symbol or all symbols; hover highlights the lines |
| Analytics | Net P&L, win rate, profit factor, average win / loss, maximum drawdown, equity curve |

## 4. Shortcuts

| Feature | Details |
|---|---|
| Hotkeys | Ctrl+Shift+letter: buy, sell, close, break-even, partial close, collapse; each bindable; global switch; cooldown 0–5000 ms |
| Close all | Closes this symbol's positions with the panel's magic number; pending orders are kept |

## 5. Chart and symbols

| Feature | Details |
|---|---|
| Symbol search | Grouped by category and exchange, favourites, keyboard navigation; exact > prefix > contains > description ranking |
| Chart workflow | Wheel zoom, drag to pan, free vertical scale, dark style, candle countdown |
| Indicators | EMA 20, ATR 14 (built-in MT5 indicators, can be switched off) |

## 6. Safety and compatibility

| Feature | Details |
|---|---|
| Account types | Hedging, netting and exchange accounts (netting partial close via an opposite deal) |
| Live accounts | One-time risk confirmation; panel is read-only until confirmed; optional *demo only* |
| Magic-number isolation | Manages only its own magic number by default; other orders shown read-only |
| Exact tickets | Every modify / close is bound to ticket, account and symbol; stale clicks are rejected |
| Language | English / 中文 / follow the terminal |
| Display | DPI-aware text and layout; interface font chosen per platform |
| Performance | ~1.3 ms per drag frame, 0.5 ms per hover (EA side) |
| License | Key bound to the MT5 account number, verified offline; the Strategy Tester needs no key |

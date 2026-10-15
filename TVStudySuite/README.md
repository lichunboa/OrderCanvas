# TVStudySuite — open-source notices

`TVStudySuite` is the price-action study workbench bundled with OrderCanvas
(moving averages & patterns, bar count, entry signals). It is a MetaTrader 5
translation of three open-source TradingView scripts and is distributed under the
**Mozilla Public License 2.0** (`LICENSE-MPL-2.0.txt`).

| Module | Original script | Author |
|---|---|---|
| Moving averages & patterns (PAIO) | [Price Action All In One](https://www.tradingview.com/script/n78QYp0G-Price-Action-All-In-One/) | fengyangsi — declared MPL-2.0 |
| Entry signals (H1/H2/L1/L2) | [Al Brooks Second Entry](https://www.tradingview.com/script/YUixSlPL-Al-Brooks-Second-Entry/) | PriceActionTrader1 |
| Bar count | [Al Brooks - Bar Count](https://www.tradingview.com/script/ii46qxIE/) | labmem004 |

TradingView applies MPL-2.0 to published open-source scripts that declare no
other license ([TradingView policies](https://www.tradingview.com/policies/)).

- The files in `MQL5/` are the complete source of the bundled `TVStudySuite.ex5`
  (and of the copy embedded in `OrderCanvas.ex5`). Keep these notices when you
  redistribute them; modified MPL files must stay under MPL-2.0.
- The ports reproduce the configuration listed in the OrderCanvas feature docs;
  not every optional mode of the original scripts is ported.
- The MPL covers these study files only. The OrderCanvas trading panel is a
  separate, proprietary work that uses the suite as a larger work (MPL-2.0 §3.3).
- Not affiliated with or endorsed by TradingView, the original authors or Al Brooks.

## Build from source
Copy `MQL5/Indicators` and `MQL5/Include` into your terminal's data folder
(File → Open Data Folder), open `Indicators/TVStudySuite.mq5` in MetaEditor and
compile (F7).

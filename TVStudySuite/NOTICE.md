# TVStudySuite — open-source notices

`TVStudySuite` is the price-action study workbench bundled with OrderCanvas
(moving averages & patterns, bar count, entry signals). It is a MetaTrader 5
translation of three open-source TradingView scripts and is distributed under the
**Mozilla Public License 2.0** (`LICENSE-MPL-2.0.txt`).

| Module | Original script | Author |
|---|---|---|
| Moving averages & patterns (PAIO) | [Price Action All In One](https://www.tradingview.com/script/n78QYp0G-Price-Action-All-In-One/) | fengyangsi |
| Entry signals (H1/H2/L1/L2) | [Al Brooks Second Entry](https://www.tradingview.com/script/YUixSlPL-Al-Brooks-Second-Entry/) | PriceActionTrader1 |
| Bar count | [Al Brooks - Bar Count](https://www.tradingview.com/script/ii46qxIE/) | labmem004 |

TradingView applies MPL-2.0 by default to published open-source scripts **unless an author selects a different license** ([publishing rules](https://www.tradingview.com/pine-script-docs/writing/publishing/); [policies](https://www.tradingview.com/policies/)). All three upstream pages are marked open source, but each *exact source header/version* still needs verification before claiming complete commercial-redistribution clearance.

See [file-to-author provenance and outstanding checks](MQL5/Indicators/THIRD_PARTY.md).

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

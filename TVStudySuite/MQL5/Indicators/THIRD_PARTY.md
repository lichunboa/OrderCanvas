# Third-party origins for TVStudySuite

[Repository-level license and attribution](../../NOTICE.md)

This file documents the original public-source works represented in the MT5-native `TVStudySuite` translation. **Open-source publication and default licensing have been confirmed at the platform level; the exact license header of each source revision and any alternative author-selected license have NOT been independently verified.** The maintainers must inspect the upstream Pine source and record a dated license snapshot before final commercial distribution.

| MT5 module | Upstream work | Author | Source publication | Current license evidence |
|---|---|---|---|---|
| `TVWorkbenchPA.mqh` | [Price Action All In One](https://www.tradingview.com/script/n78QYp0G-Price-Action-All-In-One/) | fengyangsi | TradingView, public **open-source script** | Default MPL-2.0 if no alternative header; exact original header unverified |
| `TVWorkbenchSE.mqh`, `TVSecondEntryDomain.mqh` | [Al Brooks Second Entry](https://www.tradingview.com/script/YUixSlPL-Al-Brooks-Second-Entry/) | PriceActionTrader1 | TradingView, public **open-source script** | Default MPL-2.0 if no alternative header; exact original header unverified |
| `TVWorkbenchBC.mqh` | [Al Brooks - Bar Count](https://www.tradingview.com/script/ii46qxIE/) | labmem004 | TradingView, public **open-source script** | Default MPL-2.0 if no alternative header; exact original header unverified |

TradingView confirms that published open-source Pine scripts use MPL-2.0 **by default** unless their creators choose another license. See [TradingView's publishing documentation](https://www.tradingview.com/pine-script-docs/writing/publishing/), [terms](https://www.tradingview.com/policies/) and [source reuse/House Rules](https://www.tradingview.com/support/solutions/43000590599-script-publishing-rules/). Platform terms and rights in modified or commercially redistributed versions should be independently checked before making legal assurances.

What this project does:
- Provides its MQL5 adaptations and associated supporting sources in the [TVStudySuite directory](../..) under MPL-2.0, with the actual [MPL-2.0 text](../../LICENSE-MPL-2.0.txt).
- Attributes each original author above. It does **not** claim ownership of those authors' original code, affiliation with TradingView or endorsement by Al Brooks.
- Keeps the standalone commercial trade-panel implementation under a **separate proprietary license**. The MPL-covered source must remain available when a covered version is distributed.

**Open audit items:** inspect the original Pine header at the exact revision used, preserve upstream author/license snapshots, determine any commercial-redistribution terms that matter for the MT5 distribution, and verify source/binary correspondence for each tagged release. This document is provenance disclosure, **not a completed legal clearance**.

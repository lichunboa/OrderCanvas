# What is open source in OrderCanvas?

[中文](OPEN_SOURCE.zh-CN.md) · [OpenUtilities](../OpenUtilities/) · [TVStudySuite](../TVStudySuite/) · [Commercial license](../LICENSE)

OrderCanvas combines **an independently developed proprietary MT5 chart-trading product** with separately licensed open-source components. **A public GitHub repository does not mean every file or the trading panel itself is open source.**

| Component | License | Source availability |
|---|---|---|
| `TVStudySuite/` price-action workbench, source and attribution | **MPL-2.0** | Complete covered-source files published in this repository; based on identified third-party open-source TradingView scripts |
| `OpenUtilities/` standalone lot-sizing and candle-countdown tools | **MIT** | Source plus host-side tests published in this repository |
| Commercial `OrderCanvas.ex5`, order ticket, chart drawing, trade execution, risk and order management, licensing | **Proprietary** | Binary distribution only; these source files are not published |
| Product screenshots and documentation outside separately licensed subdirectories | Rights reserved; sharing terms in [root LICENSE](../LICENSE) | Public to read, not automatically MIT/MPL software |

## Third-party attribution

The TVStudySuite translation incorporates and adapts material from three third-party scripts. Their authors and original links appear in [TVStudySuite/NOTICE.md](../TVStudySuite/NOTICE.md), with the full [MPL-2.0 license](../TVStudySuite/LICENSE-MPL-2.0.txt). The original authors retain their respective copyrights; the OrderCanvas authors claim only their own lawful additions and adaptations. The original authors, TradingView and MetaQuotes do not endorse OrderCanvas.

OpenUtilities is a curated, independently separable subset of OrderCanvas's MQL5 utility code. The code and accompanying tests were extracted from the project sources for reproducible reuse. It is *not* a publication of the commercial program's internals.

## Commercial use

- MIT-licensed OpenUtilities may be used in commercial or open-source software, subject to preserving its copyright and license notice. Buying OrderCanvas is **not required** to use these tools.
- MPL-2.0-covered TVStudySuite source may be redistributed under its terms, including source availability and notices for covered files. Its terms are **not replaced** by the commercial license.
- The commercially distributed OrderCanvas trading panel and activation keys are governed by the [separate proprietary license](../LICENSE). Purchasing or running a binary does not grant a license to redistribute the closed-source panel, publish its code or generate third-party activation keys.
- A license-verification *mechanism* can be discussed openly without revealing or publishing signing credentials; no customer keys, database, signing secrets or private infrastructure configuration are public.

## Contributions and requests

Contributions are welcome **only to the explicitly open-source directories**, with compliance to their licenses and the [contributing guide](../CONTRIBUTING.md). Please submit reproducible tests, broker-neutral fixes and documentation improvements. Do not post license keys, account details, passwords or undisclosed vulnerabilities in public issues. For commercial product support, use the links in the root README.

We assess future utility modules in small batches, checking copyright provenance, dependency isolation, tests and sensitive-data exposure before publication. **No other private module is implicitly promised or licensed for public release.**

*Licensing summary, not a substitute for legal advice.*

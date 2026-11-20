# Repository guide

This GitHub repository has **two audiences**, but only selected directories contain open-source software.

| Location | Audience | Purpose / license |
|---|---|---|
| `README.md`, `README.zh-CN.md` | Traders / visitors | Product overview, screenshots, how to get the compiled panel |
| `docs/INSTALL.md`, `docs/FEATURES*.md` | Customers | Installation, usage and commercial feature descriptions |
| `OpenUtilities/MQL5/Include` | MQL5 developers | Six small standalone helpers; **MIT** |
| `OpenUtilities/tests` | Contributors | Portable C++ tests for those helpers |
| `TVStudySuite/MQL5/Indicators` and `Include` | MQL5 developers | Price-action workbench MQL5 source; **MPL-2.0** |
| `TVStudySuite/NOTICE.md`, `LICENSE-MPL-2.0.txt` | Redistributors | Upstream attribution and file-level copyleft terms |
| `docs/OPEN_SOURCE*.md` | Everyone | Open/proprietary boundary and third-party provenance |
| `docs/DEVELOPERS*.md` | Contributors | Building, testing, reporting and contributing |
| `.github/`, `CONTRIBUTING.md`, `SECURITY.md` | Community | Issue templates, CI for public utilities and responsible disclosure |
| `CHANGELOG.md`, `Releases` | Customers | Released products and historical packages |
| `LICENSE` | Everyone | Proprietary product terms with explicit OSS exceptions |

The commercial panel's MQL5 source, UI renderer, order/position execution, license signing and private release infrastructure are **not in this public tree**. Do not infer that a public binary carries an MIT/MPL license; check each component's location and notice.

## Suggested reading paths

**Trader:** root README → features → installation → release notes → download.

**Developer:** [developer quickstart](DEVELOPERS.md) → [OpenUtilities](../OpenUtilities/) or [TVStudySuite](../TVStudySuite/) → tests → [contributing](../CONTRIBUTING.md).

**Auditor:** [open-source policy](OPEN_SOURCE.md) → [third-party manifest](../TVStudySuite/MQL5/Indicators/THIRD_PARTY.md) → exact upstream source headers and tagged release files.

## Release integrity

The public repository is curated from an internal source tree, not the full engineering workspace. Community PRs should only target OSS directories and docs. The internal publishing process must carry public source, copyright notices and tests forward into each subsequent release. Published-source presence is not proof that all optional features, screenshots or broker environments have received live native acceptance.

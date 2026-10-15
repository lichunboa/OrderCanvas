# Developer guide — open-source modules

[中文](DEVELOPERS.zh-CN.md) · [Repository architecture](PROJECT_STRUCTURE.md) · [Licensing](OPEN_SOURCE.md)

OrderCanvas is both a commercial MetaTrader 5 trading panel and a host for separately licensed open-source tools. **Only `OpenUtilities/` (MIT) and `TVStudySuite/` (MPL-2.0) are open-source software.** The commercial panel's source, execution engine and activation system are not in this repository.

## Start with the standalone utilities

1. Browse [OpenUtilities](../OpenUtilities/), choose a small `.mqh` module and read its exact license.
2. Copy it to the MT5 data folder under `MQL5/Include`, or include it from your own indicator, script or EA.
3. Reproduce its independent C++ host-side tests:

```sh
for src in OpenUtilities/tests/*.cpp; do
  c++ -std=c++17 -Wall -Wextra -Werror -O2 "$src" -o /tmp/oc-utility-test
  /tmp/oc-utility-test
done
```

The test harness adapts MQL5 standard numerical/string helpers to portable C++; it does **not** emulate broker execution, test chart mouse events or prove Windows/MT5 compatibility. For genuine use, also compile in MetaEditor and test with your broker's symbol constraints.

## Build the open-source indicator

1. Read [TVStudySuite's provenance and MPL notices](../TVStudySuite/NOTICE.md) and [third-party origin map](../TVStudySuite/MQL5/Indicators/THIRD_PARTY.md).
2. In MT5, select **File → Open Data Folder**.
3. Copy both `TVStudySuite/MQL5/Indicators` and `TVStudySuite/MQL5/Include` into the corresponding `MQL5/` folders.
4. Open `MQL5/Indicators/TVStudySuite.mq5` in MetaEditor, compile and add it to a **demo** chart.

Third-party upstream license headers and commercial redistribution scope are under additional audit. Do not remove upstream attribution when making modified distributions.

## Where to report problems

- **Bug / compatibility issue:** use the [GitHub bug form](../.github/ISSUE_TEMPLATE/bug_report.yml). Remove trade account IDs, order tickets, secrets and private transaction data from logs and screenshots.
- **Improvement proposal:** use the [feature form](../.github/ISSUE_TEMPLATE/feature_request.yml).
- **Security issue:** follow [SECURITY.md](../SECURITY.md); never publish exploit details or license keys in Issues.
- **Contributing code:** see [CONTRIBUTING.md](../CONTRIBUTING.md). PRs should be limited to publicly licensed directories.

## What is *not* provided

No commercial EA source, broker connectors, license signing implementation, private dashboards, customer records, internal integration-test environments or evidence for unpublished versions. GitHub Releases may contain compiled commercial binaries, but that does not license the binary source for redistribution.

If you are here as a trader rather than a developer, use the [product installation guide](INSTALL.md) and [features](FEATURES.md).

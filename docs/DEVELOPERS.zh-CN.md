# 开发者入门

[English](DEVELOPERS.md) · [公开仓库架构](PROJECT_STRUCTURE.md) · [许可证边界](OPEN_SOURCE.zh-CN.md)

OrderCanvas 同时提供商业 MT5 图表交易面板与独立开源模块。**只有 `OpenUtilities/`（MIT）及 `TVStudySuite/`（MPL-2.0）是开放源码**，商业面板、交易执行及授权引擎不包含在公开仓库。

## 开始使用开源工具

1. 进入 [OpenUtilities](../OpenUtilities/)，阅读要复用的 `.mqh` 文件及所在目录 MIT 许可。
2. 把文件复制到 MT5 数据目录 `MQL5/Include`，在自己的 MQL5 指标、脚本或 EA 中引用。
3. 通过独立测试确认纯逻辑行为：

```sh
for src in OpenUtilities/tests/*.cpp; do
  c++ -std=c++17 -Wall -Wextra -Werror -O2 "$src" -o /tmp/oc-utility-test
  /tmp/oc-utility-test
done
```

上面运行的是宿主 C++ 适配测试，不能代替 MetaEditor 编译、券商品种参数以及 Windows 图表真实交互测试。

## 编译开放指标

阅读 [TVStudySuite 版权声明](../TVStudySuite/NOTICE.md) 和 [第三方来源清单](../TVStudySuite/MQL5/Indicators/THIRD_PARTY.md)；在 MT5 的「文件 → 打开数据文件夹」中，把 `TVStudySuite/MQL5/Indicators` 和 `Include` 复制到对应目录，再用 MetaEditor 编译 `Indicators/TVStudySuite.mq5`。建议先在模拟图表上确认效果。

**注意：**目前对三个 TradingView 原始项目的逐版本许可证头与商业再分发条款仍需补充审计；重新发布改编作品时不得删除第三方署名。

## 如何参与

- [Bug 反馈](../.github/ISSUE_TEMPLATE/bug_report.yml)：提供复现步骤、MT5 环境和已去敏的日志。
- [功能建议](../.github/ISSUE_TEMPLATE/feature_request.yml)：明确希望解决的实际问题。
- [安全问题](../SECURITY.md)：私下报告，不公开账户、订单号、密钥或漏洞利用细节。
- [提交代码](../CONTRIBUTING.md)：只对明确开源的目录贡献代码，遵守 MIT/MPL 许可。

只想安装交易面板？直接看 [安装说明](INSTALL.md) 和 [功能介绍](FEATURES.zh-CN.md)。

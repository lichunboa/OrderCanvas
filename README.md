<div align="center">

# OrderCanvas

**MT5 图表交易面板 · 在图上直接下单、拖动订单线、管理持仓**
**Chart trading panel for MetaTrader 5 — trade, drag and manage orders right on the chart**

[购买 / 免费试用 · Buy / Free trial](https://t.me/OrderCanvasbot) · [安装与激活 · Install](docs/INSTALL.md) · [全部功能 · Features](docs/FEATURES.md) · [更新日志 · Changelog](CHANGELOG.md)

</div>

![OrderCanvas panel](images/panel.png)

## 为什么用 OrderCanvas

MT5 自带的下单窗口每次都要弹框、手算手数、再去改止盈止损。OrderCanvas 把这些都放到图表上：

- **先预览再下单**：选好方向后，入场、止盈、止损先以浅色草稿线画在图上，拖到满意的位置再确认发送。
- **订单线直接拖**：拖动持仓线、挂单线、止盈止损线即可改价；从订单线上把 TP / SL 拉出来就是新的保护单。
- **持仓线上一键操作**：保本（可计入手续费、隔夜利息和滑点缓冲）、按比例部分平仓、反手、平仓，确认框就在鼠标旁边。
- **按风险算手数**：手数、保证金、余额百分比、风险金额、风险百分比五种方式，按止损距离自动反算手数。
- **一键交易**：点卖价 / 买价直接成交，底部按钮变为「一键平仓」。
- **分批止盈**：每个持仓最多 3 个额外止盈价位，到价自动按比例平仓。
- **订单面板 + 交易分析**：持仓、挂单、历史、账户、分析五页；净盈亏、胜率、利润因子、最大回撤、资金曲线一屏看完。
- **中文 / English**，深色主题，Windows 与 Mac（MT5 for Mac）都可用；对冲与净额账户都支持。

<table>
<tr>
<td><img src="images/chip-draft.png" alt="draft order line"></td>
<td><img src="images/chip-protection.png" alt="take profit line"></td>
</tr>
<tr><td align="center">下单前的草稿订单线</td><td align="center">止盈 / 止损线（圆角标签，可拖动）</td></tr>
</table>

![Analysis](images/analysis.png)

## 价格

| 方案 | 价格 | 说明 |
|---|---|---|
| 免费试用 | 0 | 7 天，1 个 MT5 账户 |
| 月付 | **19 USDT** | 2 个 MT5 账户（例如模拟 + 真实） |
| 年付 | **69 USDT** | 2 个 MT5 账户 |
| 永久 | **89 USDT** | 2 个 MT5 账户，含后续更新 |

**购买方式**：打开 Telegram 机器人 [@OrderCanvasbot](https://t.me/OrderCanvasbot) → 选择方案 → 发送 MT5 账户号码 → 按提示转账 USDT（TRC20）。到账后授权码和程序文件会**自动**发给你，通常 1–3 分钟。续期同样在机器人里完成。

> 策略测试器里可以免费试用全部功能（无需授权码），买之前可以先回测体验。

## 安装与激活（3 步）

1. 把 `OrderCanvas.ex5` 放进 MT5 **文件 → 打开数据文件夹 → MQL5 → Experts**，在导航器里右键 **刷新**。
2. 把 OrderCanvas 拖到任意图表，勾选 **允许算法交易**。
3. 按 **F7 → 输入参数 → LicenseKey**，粘贴授权码，点确定。同一台电脑只需输入一次。

详细说明见 [docs/INSTALL.md](docs/INSTALL.md)。

## 安全与隐私

- 授权码离线校验，绑定你的 MT5 账户号码；不联网、不使用 DLL、不收集任何交易数据。
- 真实账户首次使用会弹出风险确认；所有修改和平仓都绑定具体订单号、账户和品种。
- 只管理本面板魔术号的订单（可设置），不会动你的其他 EA 或手动单。

## 风险提示

外汇、贵金属和差价合约交易风险很高，可能损失全部本金。OrderCanvas 是交易操作工具，不提供交易信号或投资建议，使用前请先在模拟账户熟悉。

---

## English

OrderCanvas brings a modern chart-trading workflow to MetaTrader 5:

- **Preview before you send** — entry, TP and SL appear as light draft lines; drag them, then confirm.
- **Drag order lines** to modify positions, pending orders and protection; pull a new TP/SL out of an order line.
- **Position-line actions** — break-even (optionally covering commission, swap and a slippage buffer), partial close by share, reverse, close.
- **Risk-based sizing** by lots, margin, % balance, money or % risk from the stop distance.
- **One-click trading**, **staged take-profit** (up to 3 extra levels), **order panel and trade analytics** (net P&L, win rate, profit factor, drawdown, equity curve).
- English / 中文 UI, works on hedging and netting accounts, Windows and MT5 for Mac.

**Pricing:** free 7-day trial · 19 USDT / month · 69 USDT / year · 89 USDT lifetime (2 MT5 accounts each).
**Buy:** Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot) — pick a plan, send your MT5 account number, pay USDT (TRC20); your key and the program arrive automatically.
**Activate:** put `OrderCanvas.ex5` into `MQL5/Experts`, attach it to a chart, press F7 → Inputs → `LicenseKey`. Full guide: [docs/INSTALL.md](docs/INSTALL.md).

The Strategy Tester runs every feature without a key, so you can evaluate it first.

*Trading leveraged products carries a high level of risk. OrderCanvas is a trading tool and does not provide signals or investment advice.*

© 2026 OrderCanvas. All rights reserved. See [LICENSE](LICENSE).

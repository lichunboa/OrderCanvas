# 安装与激活 · Install & activate

## 1. 获取程序和授权码

在 Telegram 打开 [@OrderCanvasbot](https://t.me/OrderCanvasbot)：

1. 发送 `/start`，选择 **免费试用** 或付费方案；
2. 发送你的 **MT5 账户号码**（纯数字，在 MT5 窗口标题栏或「导航器 → 账户」里能看到）；
3. 付费方案按提示转账 **精确金额** 的 USDT（**TRC20** 网络），到账后自动收到授权码和 `OrderCanvas.ex5`；
4. 随时发送 `/mykeys` 取回最新授权码（续期后授权码会更新）。

> 一个授权最多绑定 2 个 MT5 账户（如模拟 + 真实）；每个账户各要一个授权码，可以用逗号分隔一起粘贴。

## 2. 安装

1. 打开 MT5，菜单 **文件 → 打开数据文件夹**；
2. 进入 `MQL5\Experts`，把 `OrderCanvas.ex5` 复制进去；
3. 回到 MT5，在 **导航器 → EA 交易** 上右键 **刷新**，就能看到 OrderCanvas。

## 3. 加载并激活

1. 把 OrderCanvas 拖到任意图表（推荐 XAUUSD / EURUSD 等常用品种）；
2. 在弹出的窗口里勾选 **允许算法交易**；
3. 切到 **输入参数**，在 `LicenseKey` 里粘贴授权码，点确定。

激活成功后面板立即出现。同一台电脑上输入一次后会自动记住，其他图表和重启 MT5 都不用再输。

未激活时图表中央会显示授权卡片，上面有你的账户号码和原因（未输入 / 无效 / 属于其他账户 / 已到期）。

## 4. 常见问题

- **工具栏的「算法交易」按钮要开着**，否则无法下单。
- **换了 MT5 账户**：新账户需要自己的授权码（在机器人里用同一订单续期或补绑）。
- **到期前 7 天**启动时会提醒；到期后面板会关闭，已设置的分批止盈在本次运行中继续执行完。
- **字体**：默认自动选择（Windows：微软雅黑 UI；Mac：苹方），也可在 `InterfaceFont` 里指定。

---

## English

1. Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot): `/start` → choose a plan → send your MT5 account number → pay the exact USDT (TRC20) amount → key and `OrderCanvas.ex5` arrive automatically. `/mykeys` shows your current keys.
2. MT5 **File → Open Data Folder → MQL5\Experts**, copy `OrderCanvas.ex5`, refresh the Navigator.
3. Drag OrderCanvas onto a chart, allow algo trading, **Inputs → LicenseKey**, paste, OK. Each computer asks only once.

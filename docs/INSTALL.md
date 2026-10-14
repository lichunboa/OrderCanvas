# 安装与激活 · Install & activate

## 1. 获取程序和授权码

在 Telegram 打开 [@OrderCanvasbot](https://t.me/OrderCanvasbot)：

1. 发送 `/start`，选择 **免费试用** 或付费方案；
2. 发送你的 **MT5 账户号码**（纯数字，在 MT5 窗口标题栏或「导航器 → 账户」里能看到）；
3. 付费方案按页面金额转 USDT（**TRC20** 网络，两位小数，例如 19.37；小数尾数用来自动识别订单，交易所扣了整数手续费也能识别），到账后自动收到授权码和安装包 `OrderCanvas.zip`；
4. 随时发送 `/mykeys` 取回最新授权码（续期后授权码会更新）。

> 一个授权最多绑定 2 个 MT5 账户（如模拟 + 真实）；每个账户各要一个授权码，可以用逗号分隔一起粘贴。

## 2. 安装

**Windows（推荐，一键）**
1. 解压 `OrderCanvas.zip`；
2. 双击 `Install.bat`：自动把程序（`OrderCanvas.ex5`）和推荐图表模板（`OrderCanvas.tpl`）装进这台电脑上**所有**的 MT5，并显示装到了哪几个；
3. 重启 MT5（或在 **导航器 → EA 交易** 上右键 **刷新**）。

便携版 MT5（装在单独文件夹、用 `/portable` 启动的）：在解压目录里打开 PowerShell，运行 `.\install.ps1 -Target D:\你的MT5文件夹`。

**Mac / 手动**
1. MT5 菜单 **文件 → 打开数据文件夹**；
2. `OrderCanvas.ex5` 复制到 `MQL5\Experts`，`OrderCanvas.tpl` 复制到 `MQL5\Profiles\Templates`；
3. 重启 MT5。

## 3. 加载并激活

1. 打开任意图表 → 右键 → **模板 → OrderCanvas**：一次加载面板、推荐配色、EMA 20 和 ATR 14 副图（也可以直接把 OrderCanvas 从导航器拖到图表）；
2. 勾选 **允许算法交易**，并确认 MT5 工具栏的「算法交易」按钮是绿色；
3. 图表中间会出现授权卡片：把授权码粘贴进输入框（Ctrl+V），点 **激活**。也可以按 **F7 → 输入参数 → `LicenseKey`** 粘贴。

安装没反应？先确认已经把压缩包**完整解压**到一个文件夹再双击 `Install.bat`；安装结果会写在同一文件夹的 `install-log.txt` 里，可以发给卖家。

模板只是起点：配色、周期、指标都可以随意改，改完右键 → 模板 → 保存模板即可。ATR 副图可以拖动分隔线调高度，不需要时直接删掉，之后不会再自动加回来。面板默认每次加载会套用深色配色，想完全用自己的配色，把输入参数 `MatchTradingViewChartStyle` 设为 `false`。

激活成功后面板立即出现。同一台电脑上输入一次后会自动记住，其他图表和重启 MT5 都不用再输。

未激活时图表中央会显示授权卡片，上面有你的账户号码和原因（未输入 / 无效 / 属于其他账户 / 已到期）。

## 4. 常见问题

- **工具栏的「算法交易」按钮要开着**，否则无法下单。
- **换了 MT5 账户**：新账户需要自己的授权码（在机器人里用同一订单续期或补绑）。
- **到期前 7 天**启动时会提醒；到期后面板会关闭，已设置的分批止盈在本次运行中继续执行完。
- **字体**：默认自动选择（Windows：微软雅黑 UI；Mac：苹方），也可在 `InterfaceFont` 里指定。

---

## English

1. Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot): `/start` → choose a plan → send your MT5 account number → pay the USDT (TRC20) amount shown (2 decimals; the cents identify your order) → key and `OrderCanvas.zip` arrive automatically. `/mykeys` shows your current keys.
2. Unzip `OrderCanvas.zip` and double-click `Install.bat` (Windows) - or copy `OrderCanvas.ex5` to `MQL5\Experts` and `OrderCanvas.tpl` to `MQL5\Profiles\Templates` (Mac / manual).
3. Restart MT5, right-click a chart → Templates → OrderCanvas (panel, colours, EMA 20 and a resizable ATR 14 pane; a portable MT5 installs with `install.ps1 -Target <folder>`), allow algo trading, paste the key into the license card and click Activate (or F7 → Inputs → `LicenseKey`). Each computer asks only once. If nothing happens, make sure the zip was fully extracted first; the result is written to `install-log.txt`.

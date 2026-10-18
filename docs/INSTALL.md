# 安装与激活 · Install & activate

## 1. 获取程序和授权码

在 Telegram 打开 [@OrderCanvasbot](https://t.me/OrderCanvasbot)：

1. 发送 `/start`，选择 **免费试用** 或付费方案；
2. 发送你的 **MT5 账户号码**（纯数字，在 MT5 窗口标题栏或「导航器 → 账户」里能看到）；
3. 付费方案按页面金额转 USDT（**TRC20** 网络，两位小数，例如 19.37；小数尾数用来自动识别订单，交易所扣了整数手续费也能识别），到账后自动收到授权码和安装包 `OrderCanvas.zip`；
4. 随时发送 `/mykeys` 取回最新授权码（续期后授权码会更新）。

> 一个授权最多绑定 2 个 MT5 账户（如模拟 + 真实）；每个账户各要一个授权码，可以用逗号分隔一起粘贴。

## 2. 安装

**Windows（一键）**
1. 右键 `OrderCanvas.zip` → **全部解压**（不要在压缩包里直接双击，那样 Windows 只取出一个文件）；
2. 双击解压出来的 `Install.bat`：把程序（`OrderCanvas.ex5`）、推荐模板（`OrderCanvas.tpl`）和工作台指标装进这台电脑上**所有**的 MT5，并列出装到了哪几个。它只复制文件，不联网、不改系统设置；
3. 重启 MT5。

- 出现「Windows 已保护你的电脑」：点 **更多信息 → 仍要运行**；
- 安全软件（360、火绒等）拦截：选 **允许**，或用下面的手动安装；
- 便携版 MT5（单独文件夹、`/portable` 启动）：把 MT5 文件夹（里面有 `MQL5`）**拖到** `Install.bat` 上。

**Mac（MetaTrader 5 for Mac，也支持券商的 Mac 版和 CrossOver）**
1. 双击 `OrderCanvas.zip` 解压；
2. 打开「终端」（启动台 → 其他 → 终端），输入 `bash` 和一个空格，把 `Install-Mac.command` 拖进终端窗口，按回车；
3. 重启 MT5。

直接双击 `Install-Mac.command` 时，macOS 会提示「无法验证开发者」或要求去「系统设置 → 隐私与安全性」批准，这是系统对所有下载脚本的拦截；用终端运行不需要批准。

**手动（任何电脑）**
1. MT5 菜单 **文件 → 打开数据文件夹**；
2. `OrderCanvas.ex5` 复制到 `MQL5\Experts`，`OrderCanvas.tpl` 复制到 `MQL5\Profiles\Templates`，`TVStudySuite.ex5` 复制到 `MQL5\Indicators`；
3. 重启 MT5。

## 3. 加载并激活

1. 打开任意图表 → 右键 → **模板 → OrderCanvas**：一次加载面板、推荐配色、EMA 20 和 ATR 14 副图（也可以直接把 OrderCanvas 从导航器拖到图表）；
2. 勾选 **允许算法交易**，并确认 MT5 工具栏的「算法交易」按钮是绿色；
3. 图表中间会出现授权卡片：把授权码粘贴进输入框（Ctrl+V），点 **激活**。也可以按 **F7 → 输入参数 → `LicenseKey`** 粘贴。

安装没反应？先确认已经把压缩包**完整解压**到一个文件夹再双击 `Install.bat`；安装窗口会列出每个 MT5 的结果，可以截图发给卖家。

模板只是起点：配色、周期、指标都可以随意改，改完右键 → 模板 → 保存模板即可。ATR 副图可以拖动分隔线调高度，不需要时直接删掉，之后不会再自动加回来。面板默认每次加载会套用深色配色，想完全用自己的配色，把输入参数 `MatchTradingViewChartStyle` 设为 `false`。

激活成功后面板立即出现。同一台电脑上输入一次后会自动记住，其他图表和重启 MT5 都不用再输。

未激活时图表中央会显示授权卡片，上面有你的账户号码和原因（未输入 / 无效 / 属于其他账户 / 已到期）。

## 4. 官方新闻（可选）

点开图表底部的日历图标，详情里可以显示美联储、欧洲央行等机构最近的官方发布。第一次使用时卡片会列出需要允许的网址：MT5 **工具 → 选项 → EA 交易**，勾选「允许 WebRequest 访问下列 URL」，把卡片里的网址逐个添加。只读这些机构公开的 RSS，不上传任何数据。MQL5 市场版没有这个功能。

## 5. 常见问题

- **工具栏的「算法交易」按钮要开着**，否则无法下单。
- **换了 MT5 账户**：新账户需要自己的授权码（在机器人里用同一订单续期或补绑）。
- **到期前 7 天**启动时会提醒；到期后面板会关闭，已设置的分批止盈在本次运行中继续执行完。
- **字体**：默认自动选择（Windows：微软雅黑 UI；Mac：苹方），也可在 `InterfaceFont` 里指定。

---

## English

1. Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot): `/start` → choose a plan → send your MT5 account number → pay the USDT (TRC20) amount shown (2 decimals; the cents identify your order) → key and `OrderCanvas.zip` arrive automatically. `/mykeys` shows your current keys.
2. Windows: right-click the zip → *Extract All*, then double-click `Install.bat` (plain copy into every MT5 on the PC, no network, no system changes; "Windows protected your PC" → *More info* → *Run anyway*; a portable MT5: drag its folder onto `Install.bat`). Mac: unzip, open Terminal, type `bash ` and drag `Install-Mac.command` into the window, press Enter (double-clicking it makes macOS ask for approval because it was downloaded). Manual: copy `OrderCanvas.ex5` to `MQL5\Experts`, `OrderCanvas.tpl` to `MQL5\Profiles\Templates`, `TVStudySuite.ex5` to `MQL5\Indicators`.
3. Restart MT5, right-click a chart → Templates → OrderCanvas, allow algo trading, paste the key into the license card and click Activate (or F7 → Inputs → `LicenseKey`). Each computer asks only once. If nothing happens, make sure the zip was fully extracted first; the installer window lists the result for every MT5.
4. Optional official news: a calendar icon's details can list the latest releases of the Fed, ECB and others. The card names the sites to allow under Tools → Options → Expert Advisors → Allow WebRequest for listed URL. Only their public RSS is read; nothing is sent. Not in the MQL5 Market build.

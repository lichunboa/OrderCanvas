# 安装与激活 · Install & activate

## 1. 获取程序和授权码

在 Telegram 打开 [@OrderCanvasbot](https://t.me/OrderCanvasbot)：

1. 发送 `/start`，选择 **免费试用** 或付费方案；
2. 发送你的 **MT5 账户号码**（纯数字，在 MT5 窗口标题栏或「导航器 → 账户」里能看到）；
3. 付费方案按页面金额转 USDT（**TRC20** 网络，两位小数，例如 19.37；小数尾数用来自动识别订单，交易所扣了整数手续费也能识别），到账后自动收到授权码和安装包 `OrderCanvas.zip`；
4. 随时发送 `/mykeys` 取回最新授权码（续期后授权码会更新）。

> 一个授权最多绑定 2 个 MT5 账户（如模拟 + 真实）；每个账户各要一个授权码，可以用逗号分隔一起粘贴。

## 2. 安装

**Windows（安装程序）**
1. 打开 `OrderCanvas.zip`，双击里面的 `OrderCanvas-Installer.exe`（不解压也可以）；
2. 安装程序列出这台电脑上的 MT5（正在运行的加粗，已装过 OrderCanvas 的已勾选），勾选要装的，点 **安装**；
3. 按窗口里的「下一步」：重启 MT5，把 OrderCanvas 拖到图表。

- 出现「Windows 已保护你的电脑」：点 **更多信息 → 仍要运行**；
- 便携版 MT5（单独文件夹、`/portable` 启动）：打开过的会自动列出；没列出时点 **添加 MT5 文件夹…** 选它的文件夹；
- MT5 装在需要管理员权限的位置时，安装程序会提示以管理员身份重新安装；
- 安装程序只复制文件，不关闭 MT5、不改设置、不碰账户和交易；
- 安全软件（360、火绒等）拦下安装程序时：把压缩包**全部解压**，双击 `Install.bat`（装进所有 MT5），或用下面的手动安装。

**Mac（MetaTrader 5 for Mac，也支持券商的 Mac 版和 CrossOver）**
1. 双击 `OrderCanvas.zip` 解压；
2. 打开「终端」（启动台 → 其他 → 终端），输入 `bash` 和一个空格，把 `Install-Mac.command` 拖进终端窗口，按回车；
3. 重启 MT5。

直接双击 `Install-Mac.command` 时，macOS 会提示「无法验证开发者」或要求去「系统设置 → 隐私与安全性」批准，这是系统对所有下载脚本的拦截；用终端运行不需要批准。

**手动（任何电脑）**
1. MT5 菜单 **文件 → 打开数据文件夹**；
2. `OrderCanvas.ex5` 复制到 `MQL5\Experts`，`OrderCanvas.tpl` 复制到 `MQL5\Profiles\Templates`；工作台已嵌入 OrderCanvas，不需要额外安装指标文件；
3. 重启 MT5。

## 3. 加载并激活

1. 把 OrderCanvas 从「导航器 → EA 交易」**拖到图表**：只加上交易面板和订单线，你原来的配色、指标和副图都不变。想要 OrderCanvas 的深色样式、EMA 20 / ATR 14 和价格行为工作台，点面板工具栏「模板」→「价格行为」（新手引导里也有说明）；
2. 勾选 **允许算法交易**，并确认 MT5 工具栏的「算法交易」按钮是绿色；
3. 图表中间会出现授权卡片：把授权码粘贴进输入框（Ctrl+V），点 **激活**。也可以按 **F7 → 输入参数 → `LicenseKey`** 粘贴。

安装没反应？安装程序的列表会写明每个 MT5 的结果（✓ 已安装 / ✗ 原因），可以截图发给卖家；用 `Install.bat` 时先把压缩包完整解压。

套用的模板只是起点：配色、周期、指标都可以随意改，改完在工具栏「模板」里保存，或右键 → 模板 → 保存模板。ATR 副图可以拖动分隔线调高度，不需要时直接删掉，之后不会再自动加回来。从旧版本升级的电脑保持原来的 OrderCanvas 样式；想完全用自己的配色，把输入参数 `MatchTradingViewChartStyle` 设为 `false`。

激活成功后面板立即出现。同一台电脑上输入一次后会自动记住，其他图表和重启 MT5 都不用再输。

未激活时图表中央会显示授权卡片，上面有你的账户号码和原因（未输入 / 无效 / 属于其他账户 / 已到期）。

## 4. 经济事件与官方发布

图表底部的经济事件来自 MT5 / MetaQuotes 自带经济日历，**不需要 WebRequest**。默认显示「高 + 中等影响」，低影响过滤；也可以改成只显示高影响。

不添加任何新闻网址，也能查看事件名称、实际 / 预期 / 前值、历史公布和来源。只有额外显示央行 / 统计局最近的**官方发布标题**时，才需要 WebRequest；OrderCanvas 会按当前品种列出需要的网址。USD 的 BEA 地址为 `https://apps.bea.gov`。

## 5. 常见问题

- **工具栏的「算法交易」按钮要开着**，否则无法下单。
- **换了 MT5 账户**：新账户需要自己的授权码（在机器人里用同一订单续期或补绑）。
- **到期前 7 天**启动时会提醒；到期后面板会关闭，已设置的分批止盈在本次运行中继续执行完。
- **字体**：默认自动选择（Windows：微软雅黑 UI；Mac：苹方），也可在 `InterfaceFont` 里指定。
- **卡顿或出错，需要我们排查**：面板设置 → 常规 → 诊断 →「发送」（需要允许联网激活用的 https://getordercanvas.com；严重卡顿时也会自动发送，可在同一处关闭）。也可以 MT5「文件 → 打开数据文件夹」，手动发送 `MQL5\Files\OrderCanvas\diagnostics.log`（电脑配置和慢操作记录，不含账户、持仓或价格）和 `MQL5\Logs` 里当天的日志（例如 `20261022.log`）。

---

## English

1. Telegram [@OrderCanvasbot](https://t.me/OrderCanvasbot): `/start` → choose a plan → send your MT5 account number → pay the USDT (TRC20) amount shown (2 decimals; the cents identify your order) → key and `OrderCanvas.zip` arrive automatically. `/mykeys` shows your current keys.
2. Windows: run `OrderCanvas-Installer.exe` from the zip, tick the terminals (running ones are bold, those with OrderCanvas already ticked; portable MT5: *Add MT5 folder…*) and click Install; if security software blocks it, extract the zip and run `Install.bat`. Mac: extract it and run `Install-Mac.command` from Terminal. Manual: copy `OrderCanvas.ex5` to `MQL5\Experts` and `OrderCanvas.tpl` to `MQL5\Profiles\Templates`; the workbench is embedded.
3. Restart MT5, drag OrderCanvas from the Navigator onto a chart (it adds the panel and order lines and keeps your colours and indicators; for our dark look, EMA / ATR and the price-action studies use the toolbar Templates menu → Price action), allow algo trading, paste the key into the license card and click Activate (or F7 → Inputs → `LicenseKey`). Each computer asks only once. The installer lists the result for every MT5 (send a screenshot to the seller if one fails).
4. Economic events use MetaTrader's built-in calendar and need no WebRequest. High + moderate impact is the default; low impact is filtered. Event name, actual / forecast / previous values, history and source remain available without any news sites. Optional official-release headlines need the matching sites listed by OrderCanvas. For BEA use `https://apps.bea.gov`.
5. Slow or something failed? Panel settings → General → Diagnostics → Send (uses the online-activation site https://getordercanvas.com; a severe freeze also sends it automatically, switchable there). Or MT5 File → Open Data Folder and send `MQL5\Files\OrderCanvas\diagnostics.log` (machine summary and slow events; no account, positions or prices) and that day's log from `MQL5\Logs` (e.g. `20261022.log`).

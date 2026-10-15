# OrderCanvas OpenUtilities 开源基础工具

[English](README.md) · [开源范围与商业授权说明](../docs/OPEN_SOURCE.zh-CN.md)

这是从 OrderCanvas 工程中独立整理的 **MQL5 通用工具函数**，使用 **MIT 许可证**发布。它们不是商业交易面板的源代码，也不包含用户授权系统。

## 第一批及第二批已开放模块

| 模块 | 用途 | 源代码 | 测试 |
|---|---|---|---|
| 资金预算换算手数 | 按资金预算、每手成本以及经纪商最小/最大手数、步长计算可行手数；不满足条件时返回 0，不擅自增加风险 | [TicketSizing.mqh](MQL5/Include/TicketSizing.mqh) | [sizing.cpp](tests/sizing.cpp) |
| K 线倒计时 | 计算剩余收盘秒数并格式化显示；收盘后归零，不会在新 K 线出现前假循环 | [TVCandleClockDomain.mqh](MQL5/Include/TVCandleClockDomain.mqh) | [candle_clock.cpp](tests/candle_clock.cpp) |
| 有效期日历（第二批） | 检查公历日期、时间范围和 MT5 订单有效期能力位；不包含实际下单逻辑 | [TVExpiryCalendar.mqh](MQL5/Include/TVExpiryCalendar.mqh) | [expiry_calendar.cpp](tests/expiry_calendar.cpp) |
| 垂直区域重叠判断（第二批） | 判断两段**正高度**的 Y 轴区间是否重叠；边界刚好接触不算重叠，不含面板布局、拖拽和绘图实现 | [TVOverlayRowIntervals.mqh](MQL5/Include/TVOverlayRowIntervals.mqh) | [overlay_rows.cpp](tests/overlay_rows.cpp) |

将需要的 `.mqh` 文件放到自己的 MQL5 `Include` 目录并引用即可。注意：预算手数计算的 **每手成本须由调用方结合品种和经纪商数据计算**；本函数本身不会估算保证金、滑点或真实最大亏损。返回 0 表示没有满足限制的手数。有效期工具只判断输入数据及能力位，不读取券商服务器当前时间，也不会下单；区间重叠工具要求传入正高度，不负责完整 UI 裁剪。

### 运行基础测试

```sh
c++ -std=c++17 -O2 tests/sizing.cpp -o /tmp/oc-sizing && /tmp/oc-sizing
c++ -std=c++17 -O2 tests/candle_clock.cpp -o /tmp/oc-clock && /tmp/oc-clock
c++ -std=c++17 -O2 tests/expiry_calendar.cpp -o /tmp/oc-expiry && /tmp/oc-expiry
c++ -std=c++17 -O2 tests/overlay_rows.cpp -o /tmp/oc-overlap && /tmp/oc-overlap
```

这两项是纯逻辑跨平台测试；不能替代 MetaEditor 编译和不同经纪商环境下的测试。

### 开源与商业边界

仅 **`OpenUtilities/` 内的文件**适用该目录的 [MIT 许可证](LICENSE)。`TVStudySuite/` 仍为 MPL-2.0，商业面板 `OrderCanvas.ex5`、UI/图表交易引擎、交易执行、账户授权等仍属专有软件。

本工具不是自动交易策略，不提供投资建议，不保证在实盘环境下的适用性。详细来源与后续开源范围请见 [开源说明](../docs/OPEN_SOURCE.zh-CN.md)。

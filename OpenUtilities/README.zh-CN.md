# OrderCanvas OpenUtilities 开源基础工具

[English](README.md) · [开源范围与商业授权说明](../docs/OPEN_SOURCE.zh-CN.md)

这是从 OrderCanvas 工程中独立整理的 **MQL5 通用工具函数**，使用 **MIT 许可证**发布。它们不是商业交易面板的源代码，也不包含用户授权系统。

## 第一至第三批已开放模块

| 模块 | 用途 | 源代码 | 测试 |
|---|---|---|---|
| 资金预算换算手数 | 按资金预算、每手成本以及经纪商最小/最大手数、步长计算可行手数；不满足条件时返回 0，不擅自增加风险 | [TicketSizing.mqh](MQL5/Include/TicketSizing.mqh) | [sizing.cpp](tests/sizing.cpp) |
| K 线倒计时 | 计算剩余收盘秒数并格式化显示；收盘后归零，不会在新 K 线出现前假循环 | [TVCandleClockDomain.mqh](MQL5/Include/TVCandleClockDomain.mqh) | [candle_clock.cpp](tests/candle_clock.cpp) |
| 有效期日历（第二批） | 检查公历日期、时间范围和 MT5 订单有效期能力位；不包含实际下单逻辑 | [TVExpiryCalendar.mqh](MQL5/Include/TVExpiryCalendar.mqh) | [expiry_calendar.cpp](tests/expiry_calendar.cpp) |
| 垂直区域重叠判断（第二批） | 判断两段**正高度**的 Y 轴区间是否重叠；边界刚好接触不算重叠，不含面板布局、拖拽和绘图实现 | [TVOverlayRowIntervals.mqh](MQL5/Include/TVOverlayRowIntervals.mqh) | [overlay_rows.cpp](tests/overlay_rows.cpp) |
| 鼠标价格轴数学（第三批） | 把鼠标 Y 位移转换为价格变化、垂直平移和指数缩放系数 | [TVPointerPriceMath.mqh](MQL5/Include/TVPointerPriceMath.mqh) | [pointer_price_math.cpp](tests/pointer_price_math.cpp) |
| 滚轮缩放数学（第三批） | 缩放级别限幅，以及滚轮残余增量累计、反向与多刻度处理 | [TVPointerWheelMath.mqh](MQL5/Include/TVPointerWheelMath.mqh) | [pointer_wheel_math.cpp](tests/pointer_wheel_math.cpp) |

将需要的 `.mqh` 文件放到自己的 MQL5 `Include` 目录并引用即可。注意：预算手数计算的 **每手成本须由调用方结合品种和经纪商数据计算**；本函数本身不会估算保证金、滑点或真实最大亏损。返回 0 表示没有满足限制的手数。有效期工具只判断输入数据及能力位，不读取券商服务器当前时间，也不会下单；区间重叠工具要求传入正高度，不负责完整 UI 裁剪。鼠标相关函数只处理调用方提供的数字参数，不读取行情、处理鼠标焦点或执行安全拖单。滚轮的剩余增量由调用方持有并按需重置；不能据此把这些数学函数当成完整拖拽系统。

### MQL5 最小示例（不会下单）

新增 [BudgetSizingDemo.mq5](examples/BudgetSizingDemo.mq5)：将 `TicketSizing.mqh` 复制到 MT5 的 `MQL5/Include`，示例放到 `MQL5/Scripts`，在 MetaEditor 编译、于模拟图表运行。它仅用手动输入的模拟参数打印预算对应的手数，不会发送任何交易请求。**本示例尚未获得 MetaEditor 原生编译收据。**

### 运行基础测试

```sh
c++ -std=c++17 -O2 tests/sizing.cpp -o /tmp/oc-sizing && /tmp/oc-sizing
c++ -std=c++17 -O2 tests/candle_clock.cpp -o /tmp/oc-clock && /tmp/oc-clock
c++ -std=c++17 -O2 tests/expiry_calendar.cpp -o /tmp/oc-expiry && /tmp/oc-expiry
c++ -std=c++17 -O2 tests/overlay_rows.cpp -o /tmp/oc-overlap && /tmp/oc-overlap
c++ -std=c++17 -O2 tests/pointer_price_math.cpp -o /tmp/oc-pointer-price && /tmp/oc-pointer-price
c++ -std=c++17 -O2 tests/pointer_wheel_math.cpp -o /tmp/oc-pointer-wheel && /tmp/oc-pointer-wheel
```

以上是跨平台纯逻辑测试；不能替代 MetaEditor 原生编译和不同经纪商环境下的测试。

### 开源与商业边界

仅 **`OpenUtilities/` 内的文件**适用该目录的 [MIT 许可证](LICENSE)。`TVStudySuite/` 仍为 MPL-2.0，商业面板 `OrderCanvas.ex5`、UI/图表交易引擎、交易执行、账户授权等仍属专有软件。

本工具不是自动交易策略，不提供投资建议，不保证在实盘环境下的适用性。详细来源与后续开源范围请见 [开源说明](../docs/OPEN_SOURCE.zh-CN.md)。

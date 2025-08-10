<div align=center>
<img width=64 src="./HuskarUI_Qt5/resources/huskarui_icon.svg">

# 「 HuskarUI 」 基于 Qml 的现代 UI

Qt Qml 的 Ant 设计组件库

**此项目为「 HuskarUI 」Qt5 实现**

**Qt6 实现更加强大性能也更好 [HuskarUI for Qt6](https://github.com/mengps/HuskarUI)**

</div>

<div align=center>

![win-badge] ![linux-badge] ![macos-badge] ![android-badge] [![Issues][issues-image]][issues-url] [![QQGroup][qqgroup-image]][qqgroup-url]

English | [中文](./README-zh_CN.md)

</div>

[win-badge]: https://img.shields.io/badge/Windows-passing-brightgreen?style=flat-square
[linux-badge]: https://img.shields.io/badge/Linux-passing-brightgreen?style=flat-square
[macos-badge]: https://img.shields.io/badge/MacOS-passing-brightgreen?style=flat-square
[android-badge]: https://img.shields.io/badge/Android-passing-brightgreen?style=flat-square

[issues-image]: https://flat.badgen.net/github/label-issues/mengps/HuskarUI/open
[issues-url]: https://github.com/mengps/HuskarUI/issues

[qqgroup-image]: https://img.shields.io/badge/QQGroup-490328047-f74658?style=flat-square
[qqgroup-url]: https://qm.qq.com/q/cMNHn2tWeY


## 说明

提供一些有用 Qml 控件 & 实用工具

一些是 `Qt C++实现`, 也有 `纯Qml实现`

## 如何使用

### 对于 `CustomControls` 模块

- 使用 `cmake` 构建

> `CustomControls/CMakeLists.txt` 可构建所有示例
>
> 如需单独构建，直接进入目录构建 `CustomControls/*/CMakeLists.txt` 

- 使用 `qmake` 构建

> `CustomControls/Run.pro` 可构建所有示例
>
> 如需单独构建，直接进入目录构建 `CustomControls/*.pro` 


### 对于 `HuskarUI_Qt5` 模块

> 请参照 [HuskarUI Qt6](https://github.com/mengps/HuskarUI) 构建

## 🗺️ 路线图

开发计划可以在这里看到: [组件路线图](https://github.com/mengps/HuskarUI_Qt5/discussions/10).


任何人都可以通过 issue/qq群/wx群 进行讨论, 最终有意义的组件/功能将添加到开发计划.

## 所有控件&工具预览

[预览图均为GIF，较大](./demonstrate/demonstrate.md)

## 控件&工具列表 (部分动态预览图被替换为静态)

名称 | 说明 | 支持 | 示例 
---------|----------|---------|---------
 GlowCircularImage | 圆形图像/发光图像 | `Qt5` | <div align=center><img src="./demonstrate/GlowCircularImage.png" width="200" height="150" /></div>
 MagicFish | 灵动的小鱼 | `Qt5` | <div align=center><img src="./demonstrate/MagicFish.gif" width="200" height="150" /></div>
 EditorImageHelper | 编辑器图像助手(支持动图)  |  `Qt5` | <div align=center><img src="./demonstrate/EditorImageHelper.png" width="200" height="100" /></div>
 FramelessWindow | 无边框窗口 | `Qt5` | <div align=center><img src="./demonstrate/FramelessWindow.png" width="200" height="150" /></div> 
 PolygonWindow | 多边形窗口 | `Qt5` | <div align=center><img src="./demonstrate/PolygonWindow.png" width="200" height="150" /></div>
 HistoryEditor | 历史编辑器 ( 支持历史搜索 & 关键字匹配 ) | `Qt5` | <div align=center><img src="./demonstrate/HistoryEditor.gif" width="150" height="150" /></div>
 VideoOutput | Qml中支持原始视频图像格式(YUV / RGB) | `Qt5` | <div align=center><img src="./demonstrate/VideoOutput.png" width="180" height="150" /></div>
 FpsItem | Qml中显示帧率的组件 | `Qt5` | <div align=center><img src="./demonstrate/FpsItem.gif" width="160" height="150" /></div>
 ColorPicker / ColorPickerPopup | 仿 `Windows10 画图3D` 的颜色选择器, 但更加强大 | `Qt5` | <div align=center><img src="./demonstrate/ColorPicker.png" width="160" height="150" /></div>
 WaterfallFlow | 瀑布流视图(并且可以自适应)，类似小红书 | `Qt5` | <div align=center><img src="./demonstrate/WaterfallFlow.png" width="150" height="180" /></div>
 Notification | 悬浮出现在(全局/局部)页面上的通知提醒消息 | `Qt5` | <div align=center><img src="./demonstrate/Notification.gif" width="240" height="180" /></div>
 WaveProgress | 动态的水波进度条 | `Qt5` | <div align=center><img src="./demonstrate/WaveProgress.gif" width="240" height="200" /></div>

### 以下控件来自 [HuskarUI](https://github.com/mengps/HuskarUI)
### 需要该部分控件文档请构建 [HuskarUI_Qt5 Gallery](./HuskarUI_Qt5)

 名称 | 说明 | 支持 | 示例
 ---------|----------|---------|--------- 
 HusMoveMouseArea / HusResizeMouseArea | 给任意目标添加[移动/调整大小操作]的鼠标区域 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusResizeMouseArea.gif" width="260" height="190" /></div>
 HusAsyncHasher | 可对任意数据(url/text/object)生成加密哈希的异步散列器 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusAsyncHasher.png" width="150" height="180" /></div>
 HusRate | 对某个事物进行评级 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusRate.png" width="240" height="200" /></div>
 HusSystemThemeHelper | (Qt5/Qt6) 系统主题助手 `[Dark/Light]主题检测 & 感知` | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusSystemThemeHelper.png" width="240" height="110" /></div>
 HusWatermark | 可给页面的任意项加上水印 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusWatermark.png" width="250" height="140" /></div>
 HusTour(HusTourFocus/HusTourStep) | 用于分步引导用户了解产品功能的气泡组件。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTour.png" width="250" height="210" /></div>
 HusButton(HusButton/HusIconButton) | 按钮用于开始一个即时操作。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusButton.png" width="250" height="210" /></div>
 HusDivider | 用于区隔内容的分割线。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusDivider.png" width="250" height="210" /></div>
 HusSwitch | 使用开关在两种状态之间切换。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusSwitch.png" width="250" height="210" /></div>
 HusAcrylic | 亚克力/毛玻璃效果。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusAcrylic.png" width="250" height="210" /></div>
 HusRectangle | 任意角都可以是圆角的矩形。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusRoundRectangle.gif" width="250" height="210" /></div>
 HusTabView | 通过选项卡标签切换内容的组件。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTabView.png" width="250" height="210" /></div>
 HusRadio | 用于在多个备选项中选中单个状态。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusRadio.png" width="250" height="200" /></div>
 HusRadioBlock | HusRadio 变体，用于在多个备选项中选中单个状态。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusRadioBlock.png" width="250" height="200" /></div>
 HusCheckBox | 收集用户的多项选择。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusCheckBox.png" width="250" height="200" /></div>
 HusInput | 通过鼠标或键盘输入内容，是最基础的表单域的包装(即传统输入框)。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusInput.png" width="250" height="200" /></div>
 HusOTPInput | 用于接收和验证一次性口令的输入框组合，通常用于验证码或密码。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusOTPInput.gif" width="250" height="200" /></div>
 HusSlider | 滑动型输入器，展示当前值和可选范围。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusSlider.png" width="250" height="200" /></div>
 HusScrollBar | 滚动条是一个交互式栏，用于滚动某个区域或视图到特定位置。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusScrollBar.png" width="250" height="200" /></div>
 HusTimePicker | 输入或选择时间的控件。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTimePicker.png" width="250" height="250" /></div>
 HusDrawer | 屏幕边缘滑出的浮层面板。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusDrawer.png" width="250" height="200" /></div>
 HusCollapse | 可以折叠/展开的内容区域。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusCollapse.png" width="250" height="200" /></div>
 HusAvatar | 用来代表用户或事物，支持图片、图标或字符展示。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusAvatar.png" width="250" height="200" /></div>
 HusCard | 基础的卡片容器，可承载文字、列表、图片、段落，常用于后台概览页面。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusCard.png" width="250" height="200" /></div>
 HusToolTip | 简单的文字提示气泡框(替代基础ToolTip)。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusToolTip.png" width="250" height="200" /></div>
 HusPopup | 自带跟随主题切换的背景和阴影(替代基础Popup)。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusPopup.png" width="250" height="200" /></div>
 HusSelect | 下拉选择器(替代基础ComboBox)。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusSelect.png" width="250" height="200" /></div>
 HusPagination | 分页器，用于分隔长列表，每次只加载一个页面。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusPagination.png" width="250" height="200" /></div>
 HusTimeline | 时间轴，可垂直展示的时间流信息。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTimeline.png" width="250" height="200" /></div>
 HusTag | 标签，进行标记和分类的小标签。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTag.png" width="250" height="200" /></div>
 HusTableView | 表格，用于展示行列数据。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusTableView.png" width="250" height="200" /></div>
 HusAutoComplete | 提供输入框自动完成功能。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusAutoComplete.png" width="250" height="200" /></div>
 HusDatePicker | 日期选择框，输入或选择日期的控件。 | `Qt5` `Qt6` | <div align=center><img src="./demonstrate/HusDatePicker.png" width="250" height="200" /></div>


## 许可证

 使用 `MIT LICENSE`

## 开发环境

windows 11，Qt 5.15.2 / Qt 6.7.3

## Star 历史

[![Star History Chart](https://api.star-history.com/svg?repos=mengps/QmlControls&type=Date)](https://star-history.com/#mengps/QmlControls&Date)

import QtQuick 2.15
import QtQuick.Controls 2.15
import HuskarUI.Basic 1.0

import '../../Controls'

Flickable {
    contentHeight: column.height
    ScrollBar.vertical: HusScrollBar { }

    Column {
        id: column
        width: parent.width - 15
        spacing: 30

        Description {
            desc: qsTr(`
# HusCaptionBar 标题栏\n
为无边框窗口提供一个通用的标题栏。\n
* **继承自 { Rectangle }**\n
\n<br/>
\n### 支持的代理：\n
- **winIconDelegate: Component** 窗口图标代理\n
- **winTitleDelegate: Component** 窗口标题代理\n
- **winButtonsDelegate: Component** 窗口按钮代理\n
\n<br/>
\n### 支持的属性：\n
属性名 | 类型 | 默认值 | 描述
------ | --- | :---: | ---
targetWindow | var | null | 目标窗口
windowAgent | HusWindowAgent | null | 无边框窗口代理(通常不使用)
layoutDirection | enum | Qt.LeftToRight | 布局方向
winIcon | url | '' | 窗口图标
winIconWidth | real | - | 窗口图标宽度
winIconHeight | real | - | 窗口图标高度
winIconVisible | bool | true | 窗口图标是否可见
winTitle | string | '' | 窗口标题
winTitleFont | font | - | 窗口标题字体
winTitleColor | color | - | 窗口标题颜色
winTitleVisible | bool | true | 窗口标题是否可见
returnButtonVisible | bool | false | 返回按钮是否可见
themeButtonVisible | bool | false | 主题按钮是否可见
topButtonVisible | bool | false | 置顶按钮是否可见
minimizeButtonVisible | bool | true | 最小化按钮是否可见
maximizeButtonVisible | bool | true | 最大化按钮是否可见
closeButtonVisible | bool | true | 关闭按钮是否可见
returnCallback | function | function() | 按下返回按钮时回调
themeCallback | function | function() | 按下主题按钮时回调
topCallback | function | function(checked) | 按下置顶按钮时回调
minimizeCallback | function | function() | 按下最小化按钮时回调
maximizeCallback | function | function() | 按下最大化按钮时回调
closeCallback | function | function() | 按下关闭按钮时回调
contentDescription | string | - | 内容描述(提高可用性)
\n<br/>
\n### 支持的函数：\n
- \`addInteractionItem(item: var)\` 添加交互项 \`item\` (当交互项覆盖标题栏时需要使用)\n
- \`removeInteractionItem(item: var)\` 删除交互项 \`item\`\n
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
当无边框窗口需要一个通用的标题栏时使用。
                       `)
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
\`HusWindow\` 自带一个 \`HusCaptionBar\`，通常不需要单独使用。
                       `)
        }
    }
}

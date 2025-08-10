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
# HusButton 按钮\n
按钮用于开始一个即时操作。\n
* **继承自 { Button }**\n
\n<br/>
\n### 支持的代理：\n
- 无\n
\n<br/>
\n### 支持的属性：\n
属性名 | 类型 | 默认值 | 描述
------ | --- | :---: | ---
animationEnabled | bool | HusTheme.animationEnabled | 是否开启动画
effectEnabled | bool | true | 是否开启点击效果
hoverCursorShape | int | Qt.PointingHandCursor | 悬浮时鼠标形状(来自 Qt.*Cursor)
type | enum | HusButton.Type_Default | 按钮类型(来自 HusButton)
shape | enum | HusButton.Shape_Default | 按钮形状(来自 HusButton)
radiusBg | int | - | 背景圆角半径
colorText | color | - | 文本颜色
colorBg | color | - | 背景颜色
colorBorder | color | - | 边框颜色
contentDescription | string | '' | 内容描述(提高可用性)
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
标记了一个（或封装一组）操作命令，响应用户点击行为，触发相应的业务逻辑。\n
在 HuskarUI 中我们提供了五种按钮。\n
- 默认按钮：用于没有主次之分的一组行动点。\n
- 主要按钮：用于主行动点，一个操作区域只能有一个主按钮。\n
- 线框按钮：等同于默认按钮，但线框使用了主要颜色。\n
- 填充按钮：用于次级的行动点。\n
- 文本按钮：用于最次级的行动点。\n
- 链接按钮：一般用于链接，即导航至某位置。\n
                       `)
        }

        ThemeToken {
            source: 'HusButton'
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
通过 \`type\` 属性改变按钮类型，支持的类型：\n
- 默认按钮{ HusButton.Type_Default }\n
- 线框按钮{ HusButton.Type_Outlined }\n
- 主要按钮{ HusButton.Type_Primary }\n
- 填充按钮{ HusButton.Type_Filled }\n
- 文本按钮{ HusButton.Type_Text }\n
- 链接按钮{ HusButton.Type_Link }\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 15

                    HusButton {
                        text: qsTr('默认')
                    }

                    HusButton {
                        text: qsTr('线框')
                        type: HusButton.Type_Outlined
                    }

                    HusButton {
                        text: qsTr('主要')
                        type: HusButton.Type_Primary
                    }

                    HusButton {
                        text: qsTr('填充')
                        type: HusButton.Type_Filled
                    }

                    HusButton {
                        text: qsTr('文本')
                        type: HusButton.Type_Text
                    }

                    HusButton {
                        text: qsTr('链接')
                        type: HusButton.Type_Link
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 15

                HusButton {
                    text: qsTr('默认')
                }

                HusButton {
                    text: qsTr('线框')
                    type: HusButton.Type_Outlined
                }

                HusButton {
                    text: qsTr('主要')
                    type: HusButton.Type_Primary
                }

                HusButton {
                    text: qsTr('填充')
                    type: HusButton.Type_Filled
                }

                HusButton {
                    text: qsTr('文本')
                    type: HusButton.Type_Text
                }

                HusButton {
                    text: qsTr('链接')
                    type: HusButton.Type_Link
                }
            }
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
通过 \`enabled\` 属性启用或禁用按钮，禁用的按钮不会响应任何交互。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 15

                    HusButton {
                        text: qsTr('默认')
                        enabled: false
                    }

                    HusButton {
                        text: qsTr('线框')
                        type: HusButton.Type_Outlined
                        enabled: false
                    }

                    HusButton {
                        text: qsTr('主要')
                        type: HusButton.Type_Primary
                        enabled: false
                    }

                    HusButton {
                        text: qsTr('填充')
                        type: HusButton.Type_Filled
                        enabled: false
                    }

                    HusButton {
                        text: qsTr('文本')
                        type: HusButton.Type_Text
                        enabled: false
                    }

                    HusButton {
                        text: qsTr('链接')
                        type: HusButton.Type_Link
                        enabled: false
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 15

                HusButton {
                    text: qsTr('默认')
                    enabled: false
                }

                HusButton {
                    text: qsTr('线框')
                    type: HusButton.Type_Outlined
                    enabled: false
                }

                HusButton {
                    text: qsTr('主要')
                    type: HusButton.Type_Primary
                    enabled: false
                }

                HusButton {
                    text: qsTr('填充')
                    type: HusButton.Type_Filled
                    enabled: false
                }

                HusButton {
                    text: qsTr('文本')
                    type: HusButton.Type_Text
                    enabled: false
                }

                HusButton {
                    text: qsTr('链接')
                    type: HusButton.Type_Link
                    enabled: false
                }
            }
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
通过 \`shape\` 属性改变按钮形状，支持的形状：\n
- 默认形状{ HusButton.Shape_Default }\n
- 圆形{ HusButton.Shape_Circle }
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 15

                    HusButton {
                        text: qsTr('A')
                        shape: HusButton.Shape_Circle
                    }

                    HusButton {
                        text: qsTr('A')
                        type: HusButton.Type_Outlined
                        shape: HusButton.Shape_Circle
                    }

                    HusButton {
                        text: qsTr('A')
                        type: HusButton.Type_Primary
                        shape: HusButton.Shape_Circle
                    }

                    HusButton {
                        text: qsTr('A')
                        type: HusButton.Type_Filled
                        shape: HusButton.Shape_Circle
                    }

                    HusButton {
                        text: qsTr('A')
                        type: HusButton.Type_Text
                        shape: HusButton.Shape_Circle
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 15

                HusButton {
                    text: qsTr('A')
                    shape: HusButton.Shape_Circle
                }

                HusButton {
                    text: qsTr('A')
                    type: HusButton.Type_Outlined
                    shape: HusButton.Shape_Circle
                }

                HusButton {
                    text: qsTr('A')
                    type: HusButton.Type_Primary
                    shape: HusButton.Shape_Circle
                }

                HusButton {
                    text: qsTr('A')
                    type: HusButton.Type_Filled
                    shape: HusButton.Shape_Circle
                }

                HusButton {
                    text: qsTr('A')
                    type: HusButton.Type_Text
                    shape: HusButton.Shape_Circle
                }
            }
        }
    }
}

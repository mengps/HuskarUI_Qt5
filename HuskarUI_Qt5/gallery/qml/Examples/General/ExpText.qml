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
# HusCopyableText 可复制文本\n
提供统一字体和颜色的文本(替代Text)。\n
* **继承自 { Text }**\n
\n<br/>
\n### 支持的代理：\n
- 无\n
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
需要统一字体和颜色的文本时建议使用。
                       `)
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
使用方法等同于 \`Text\`
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 15

                    HusText {
                        text: qsTr('HusText文本')
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 15

                HusText {
                    text: qsTr('HusText文本')
                }
            }
        }
    }
}

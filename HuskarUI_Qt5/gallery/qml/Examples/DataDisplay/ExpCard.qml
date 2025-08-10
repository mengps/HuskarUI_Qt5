import QtQuick 2.15
import QtQuick.Layouts 1.15
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
# HusCard 卡片 \n
通用卡片容器。\n
* **继承自 { Rectangle }**\n
\n<br/>
\n### 支持的代理：\n
- **titleDelegate: Component** 卡片标题代理\n
- **extraDelegate: Component** 卡片右上角操作代理\n
- **coverDelegate: Component** 卡片封面代理\n
- **bodyDelegate: Component** 卡片主体代理\n
- **actionDelegate: Component** 卡片动作代理\n
\n<br/>
\n### 支持的属性：\n
属性名 | 类型 | 默认值 | 描述
------ | --- | :---: | ---
animationEnabled | bool | HusTheme.animationEnabled | 是否开启动画
title | string | '' | 标题文本
titleFont | font | - | 标题字体
coverSource | url | '' | 封面图片链接
coverFillMode | enum | Image.Stretch | 封面图片填充模式(来自 Image)
bodyAvatarSize | int |  40 | 内容字体
bodyAvatarIcon | int | 0 | 主体部分头像图标(来自 HusIcon)
bodyAvatarSource | url | '' | 主体部分头像链接
bodyAvatarText | string | '' | 主体部分头像文本
bodyTitle | string | '' | 主体部分标题文本
bodyTitleFont | font | - | 主体部分标题字体
bodyDescription | string | '' | 主体部分描述文本
bodyDescriptionFont | font | - | 主体部分描述字体
colorTitle | color | - | 标题文本颜色
colorBodyAvatar | color | - | 主体部分头像颜色
colorBodyAvatarBg | color | - | 主体部分头像背景颜色
colorBodyTitle | color | - | 主体部分标题颜色
colorBodyDescription | color | - | 主体部分描述颜色
\n **注意** \`[bodyAvatarIcon/bodyAvatarSource/bodyAvatarText]\`只需提供一种即可
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
最基础的卡片容器，可承载文字、列表、图片、段落。
                       `)
        }

        ThemeToken {
            source: 'HusCard'
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('典型卡片')
            desc: qsTr(`
包含标题、内容、操作区域。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusCard {
                        title: qsTr('Card title')
                        extraDelegate: HusButton { type: HusButton.Type_Link; text: qsTr('More') }
                        bodyDescription: qsTr('Card content\\nCard content\\nCard content')
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusCard {
                    title: qsTr('Card title')
                    extraDelegate: HusButton { type: HusButton.Type_Link; text: qsTr('More') }
                    bodyDescription: qsTr('Card content\nCard content\nCard content')
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('整体结构')
            desc: qsTr(`
通过代理可自由定制卡片内容: \n
- **titleDelegate: Component** 卡片标题代理\n
- **extraDelegate: Component** 卡片右上角操作代理\n
- **coverDelegate: Component** 卡片封面代理\n
- **bodyDelegate: Component** 卡片主体代理\n
- **actionDelegate: Component** 卡片动作代理\n
将代理设置为 \`Item {}\` 可以隐藏该部分。\n
                       `)
            code: `
                import QtQuick 2.15
                import QtQuick.Layouts 1.15
                import HuskarUI.Basic 1.0

                Row {
                    width: parent.width

                    HusCard {
                        id: card
                        title: qsTr('Card title')
                        extraDelegate: HusButton { type: HusButton.Type_Link; text: qsTr('More') }
                        coverSource: 'https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png'
                        bodyAvatarIcon: HusIcon.AccountBookOutlined
                        bodyTitle: 'Card Meta title'
                        bodyDescription: 'This is the description'
                        actionDelegate: Item {
                            height: 45

                            HusDivider {
                                width: parent.width
                                height: 1
                            }

                            RowLayout {
                                width: parent.width
                                height: parent.height

                                Item {
                                    Layout.preferredWidth: parent.width / 3
                                    Layout.fillHeight: true

                                    HusIconText {
                                        anchors.centerIn: parent
                                        iconSource: HusIcon.SettingOutlined
                                        iconSize: 16
                                    }
                                }

                                Item {
                                    Layout.preferredWidth: parent.width / 3
                                    Layout.fillHeight: true

                                    HusDivider {
                                        width: 1
                                        height: parent.height * 0.5
                                        anchors.verticalCenter: parent.verticalCenter
                                        orientation: Qt.Vertical
                                    }

                                    HusIconText {
                                        anchors.centerIn: parent
                                        iconSource: HusIcon.EditOutlined
                                        iconSize: 16
                                    }
                                }

                                Item {
                                    Layout.preferredWidth: parent.width / 3
                                    Layout.fillHeight: true

                                    HusDivider {
                                        width: 1
                                        height: parent.height * 0.5
                                        anchors.verticalCenter: parent.verticalCenter
                                        orientation: Qt.Vertical
                                    }

                                    HusIconText {
                                        anchors.centerIn: parent
                                        iconSource: HusIcon.EllipsisOutlined
                                        iconSize: 16
                                    }
                                }
                            }
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 40

                HusCard {
                    id: card
                    title: qsTr('Card title')
                    extraDelegate: HusButton { type: HusButton.Type_Link; text: qsTr('More') }
                    coverSource: 'https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png'
                    bodyAvatarIcon: HusIcon.AccountBookOutlined
                    bodyTitle: qsTr('Card Meta title')
                    bodyDescription: qsTr('This is the description')
                    actionDelegate: Item {
                        height: 45

                        HusDivider {
                            width: parent.width
                            height: 1
                        }

                        RowLayout {
                            width: parent.width
                            height: parent.height

                            Item {
                                Layout.preferredWidth: parent.width / 3
                                Layout.fillHeight: true

                                HusIconText {
                                    anchors.centerIn: parent
                                    iconSource: HusIcon.SettingOutlined
                                    iconSize: 16
                                }
                            }

                            Item {
                                Layout.preferredWidth: parent.width / 3
                                Layout.fillHeight: true

                                HusDivider {
                                    width: 1
                                    height: parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    orientation: Qt.Vertical
                                }

                                HusIconText {
                                    anchors.centerIn: parent
                                    iconSource: HusIcon.EditOutlined
                                    iconSize: 16
                                }
                            }

                            Item {
                                Layout.preferredWidth: parent.width / 3
                                Layout.fillHeight: true

                                HusDivider {
                                    width: 1
                                    height: parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    orientation: Qt.Vertical
                                }

                                HusIconText {
                                    anchors.centerIn: parent
                                    iconSource: HusIcon.EllipsisOutlined
                                    iconSize: 16
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: focusRect
                        width: 0
                        height: 0
                        color: 'transparent'
                        border.width: 2
                        border.color: 'red'

                        Behavior on x { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                        Behavior on y { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                        Behavior on width { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                        Behavior on height { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                    }
                }

                component Area: Rectangle {
                    width: 300
                    height: 60
                    color: hovered ? HusThemeFunctions.alpha(HusTheme.Primary.colorTextBase, 0.1) : HusTheme.Primary.colorBgBase
                    border.color: HusThemeFunctions.alpha(HusTheme.Primary.colorTextBase, 0.1)

                    property alias text: areaText.text
                    property alias hovered: hoverHandler.hovered

                    function setArea(x, y, w, h) {
                        if (hovered) {
                            hoverTimer.stop();
                            focusRect.x = x;
                            focusRect.y = y;
                            focusRect.width = w;
                            focusRect.height = h;
                        } else {
                            hoverTimer.restart();
                        }
                    }

                    HusText {
                        id: areaText
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        color: HusTheme.Primary.colorTextBase
                        font {
                            family: HusTheme.Primary.fontPrimaryFamily
                            pixelSize: HusTheme.Primary.fontPrimarySize
                        }
                    }

                    HoverHandler { id: hoverHandler }
                }

                Timer {
                    id: hoverTimer
                    interval: 2000
                    onTriggered: {
                        focusRect.width = 0;
                        focusRect.height = 0;
                    }
                }

                Column {
                    spacing: -1
                    Area {
                        text: qsTr('titleDelegate\n设置卡片标题区域代理')
                        onHoveredChanged: {
                            setArea(0, 0, 210, 60);
                        }
                    }
                    Area {
                        text: qsTr('extraDelegate\n设置卡片右上角操作区域代理')
                        onHoveredChanged: {
                            setArea(210, 0, 90, 60);
                        }
                    }
                    Area {
                        text: qsTr('coverDelegate\n设置卡片封面区域代理')
                        onHoveredChanged: {
                            setArea(0, 60, card.width, 180);
                        }
                    }
                    Area {
                        text: qsTr('bodyDelegate\n设置卡片主体区域代理')
                        onHoveredChanged: {
                            setArea(0, 240, card.width, 100);
                        }
                    }
                    Area {
                        text: qsTr('actionDelegate\n设置卡片动作区域代理')
                        onHoveredChanged: {
                            setArea(0, 340, card.width, 45);
                        }
                    }
                }
            }
        }
    }
}

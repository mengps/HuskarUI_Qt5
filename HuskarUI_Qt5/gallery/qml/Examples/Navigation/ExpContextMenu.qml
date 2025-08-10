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
# HusContextMenu 上下文菜单\n
上下文菜单，通常作为右键单击后显示的菜单。\n
* **继承自 { HusPopup }**\n
\n<br/>
\n### 支持的代理：\n
- 无\n
\n<br/>
\n### 支持的属性：\n
属性名 | 类型 | 默认值 | 描述
------ | --- | :---: | ---
animationEnabled | bool | true | 是否开启动画
initModel | list | [] | 初始菜单模型
tooltipVisible | bool | false | 是否显示工具提示
defaultMenuIconSize | int | - | 默认菜单图标大小
defaultMenuIconSpacing | int | 8 | 默认菜单图标间隔
defaultMenuWidth | int | 140 | 默认菜单宽度
defaultMenuHieght | int | 40 | 默认菜单高度
defaultMenuSpacing | int | 4 | 默认菜单间隔
subMenuOffset | int | -4 | 子菜单偏移
radiusBg | int | - | 背景圆角
\n<br/>
\n### 支持的信号：\n
- \`clickMenu(deep: int, menuKey: string, menuData: var)\` 点击任意菜单项时发出\n
  - \`deep\` 菜单项深度\n
  - \`menuKey\` 菜单项的键\n
  - \`menuData\` 菜单项数据\n
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
需要弹窗式菜单时使用（例如右键菜单），非弹窗式菜单请使用：[HusMenu](internal://HusMenu)。
                       `)
        }

        ThemeToken {
            source: 'HusMenu'
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
使用方法大致等同于 \`HusMenu\`，区别是 \`HusContextMenu\` 内建为弹窗。
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                MouseArea {
                    width: parent.width
                    height: parent.height
                    acceptedButtons: Qt.RightButton
                    onClicked:
                        (mouse) => {
                            if (mouse.button === Qt.RightButton) {
                                contextMenu.x = mouseX;
                                contextMenu.y = mouseY;
                                contextMenu.open();
                            }
                        }

                    HusContextMenu {
                        id: contextMenu
                        initModel: [
                            {
                                key: 'New',
                                label: 'New',
                                iconSource: HusIcon.FileOutlined,
                                menuChildren: [
                                    { key: 'NewFolder', label: 'Folder', },
                                    { key: 'NewImage', label: 'Image File', },
                                    { key: 'NewText', label: 'Text File', },
                                    {
                                        key: 'NewText',
                                        label: 'Other',
                                        menuChildren: [
                                            { key: 'Other1', label: 'Other1', },
                                            { key: 'Other2', label: 'Other2', },
                                        ]
                                    }
                                ]
                            },
                            { key: 'Open', label: 'Open', iconSource: HusIcon.FormOutlined, },
                            { key: 'Save', label: 'Save', iconSource: HusIcon.SaveOutlined },
                            { type: 'divider' },
                            { key: 'Exit', label: 'Exit', iconSource: HusIcon.IcoMoonExit },
                        ]
                        onClickMenu: (deep, menuKey, menuData) => copyableText.append('Click: ' + menuKey)
                    }

                    HusCopyableText {
                        id: copyableText
                        anchors.fill: parent
                        text: 'Please right-click with the mouse.'
                    }
                }
            `
            exampleDelegate: MouseArea {
                width: parent.width
                height: 200
                acceptedButtons: Qt.RightButton
                onClicked:
                    (mouse) => {
                        if (mouse.button === Qt.RightButton) {
                            contextMenu.x = mouseX;
                            contextMenu.y = mouseY;
                            contextMenu.open();
                        }
                    }

                HusContextMenu {
                    id: contextMenu
                    initModel: [
                        {
                            key: 'New',
                            label: 'New',
                            iconSource: HusIcon.FileOutlined,
                            menuChildren: [
                                { key: 'NewFolder', label: 'Folder', },
                                { key: 'NewImage', label: 'Image File', },
                                { key: 'NewText', label: 'Text File', },
                                {
                                    key: 'NewText',
                                    label: 'Other',
                                    menuChildren: [
                                        { key: 'Other1', label: 'Other1', },
                                        { key: 'Other2', label: 'Other2', },
                                    ]
                                }
                            ]
                        },
                        { key: 'Open', label: 'Open', iconSource: HusIcon.FormOutlined, },
                        { key: 'Save', label: 'Save', iconSource: HusIcon.SaveOutlined },
                        { type: 'divider' },
                        { key: 'Exit', label: 'Exit', iconSource: HusIcon.IcoMoonExit },
                    ]
                    onClickMenu: (deep, menuKey, menuData) => copyableText.append('Click: ' + menuKey)
                }

                HusCopyableText {
                    id: copyableText
                    anchors.fill: parent
                    text: 'Please right-click with the mouse.'
                }
            }
        }

        CodeBox {
            width: parent.width
            desc: qsTr(`
对于单选或多选菜单，只需简单自定义代理。
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Item {
                    width: parent.width
                    height: parent.height

                    Component {
                        id: checkIconDelegate

                        HusIconText {
                            width: menuButton.iconSize
                            iconSize: menuButton.iconSize
                            iconSource: isDark ? (HusTheme.isDark ? HusIcon.CheckOutlined : 0) :
                                                 (HusTheme.isDark ? 0 : HusIcon.CheckOutlined)
                            property bool isDark: menuButton.model.key === 'Dark'
                        }
                    }

                    HusButton {
                        text: qsTr('Open menu')
                        onClicked: {
                            contextMenu2.x = width + 5;
                            contextMenu2.y = 0;
                            contextMenu2.open();
                        }

                        HusContextMenu {
                            id: contextMenu2
                            initModel: [
                                { key: 'Open', label: 'Open', iconSource: HusIcon.FormOutlined, },
                                { key: 'Save', label: 'Save', iconSource: HusIcon.SaveOutlined },
                                { type: 'divider' },
                                { key: 'Exit', label: 'Exit', iconSource: HusIcon.IcoMoonExit },
                                { type: 'divider' },
                                { key: 'Dark', label: 'Dark', iconDelegate: checkIconDelegate, },
                                { key: 'Light', label: 'Light', iconDelegate: checkIconDelegate, },
                            ]
                            onClickMenu:
                                (deep, menuKey, menuData) => {
                                    if (menuKey === 'Dark') {
                                        galleryWindow.captionBar.themeCallback();
                                    } else if (menuKey === 'Light') {
                                        galleryWindow.captionBar.themeCallback();
                                    }
                                }
                        }
                    }
                }
            `
            exampleDelegate: Item {
                height: 100

                Component {
                    id: checkIconDelegate

                    HusIconText {
                        width: menuButton.iconSize
                        iconSize: menuButton.iconSize
                        iconSource: isDark ? (HusTheme.isDark ? HusIcon.CheckOutlined : 0) :
                                             (HusTheme.isDark ? 0 : HusIcon.CheckOutlined)
                        property bool isDark: menuButton.model.key === 'Dark'
                    }
                }

                HusButton {
                    text: qsTr('Open menu')
                    onClicked: {
                        contextMenu2.x = width + 5;
                        contextMenu2.y = 0;
                        contextMenu2.open();
                    }

                    HusContextMenu {
                        id: contextMenu2
                        initModel: [
                            { key: 'Open', label: 'Open', iconSource: HusIcon.FormOutlined, },
                            { key: 'Save', label: 'Save', iconSource: HusIcon.SaveOutlined },
                            { type: 'divider' },
                            { key: 'Exit', label: 'Exit', iconSource: HusIcon.IcoMoonExit },
                            { type: 'divider' },
                            { key: 'Dark', label: 'Dark', iconDelegate: checkIconDelegate, },
                            { key: 'Light', label: 'Light', iconDelegate: checkIconDelegate, },
                        ]
                        onClickMenu:
                            (deep, menuKey, menuData) => {
                                if (menuKey === 'Dark' && !HusTheme.isDark) {
                                    galleryWindow.captionBar.themeCallback();
                                } else if (menuKey === 'Light' && HusTheme.isDark) {
                                    galleryWindow.captionBar.themeCallback();
                                }
                            }
                    }
                }
            }
        }
    }
}

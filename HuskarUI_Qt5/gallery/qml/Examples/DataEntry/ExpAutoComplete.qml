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
# HusAutoComplete 自动完成 \n
输入框自动完成功能。\n
* **继承自 { HusInput }**\n
\n<br/>
\n### 支持的代理：\n
- **labelDelegate: Component** 弹出框标签项代理，代理可访问属性：\n
  - \`parent.textData: var\` {textRole}对应的文本数据\n
  - \`parent.valueData: var\` {valueRole}对应的值数据\n
  - \`parent.modelData: var\` 选项模型数据\n
  - \`parent.hovered: bool\` 是否悬浮\n
  - \`parent.highlighted: bool\` 是否高亮\n
- **labelBgDelegate: Component** 弹出框标签项背景代理，代理可访问属性：\n
  - \`parent.textData: var\` {textRole}对应的文本数据\n
  - \`parent.valueData: var\` {valueRole}对应的值数据\n
  - \`parent.modelData: var\` 选项模型数据\n
  - \`parent.hovered: bool\` 是否悬浮\n
  - \`parent.highlighted: bool\` 是否高亮\n
\n<br/>
\n### 支持的属性：\n
属性名 | 类型 | 默认值 | 描述
------ | --- | :---: | ---
options | list | [] | 选项模型列表
filterOption | function | - | 输入项将使用该函数进行筛选
textRole | string | 'label' | 弹出框文本的模型角色。
valueRole | string | 'value' | 弹出框值的模型角色。
tooltipVisible | bool | false | 是否显示文字提示
clearEnabled | bool | true | 是否启用清除按钮
defaultPopupMaxHeight | int | 240 | 默认弹出框最大高度
defaultOptionSpacing | int | 0 | 默认选项间隔
\n<br/>
\n### 支持的函数：\n
- \`clearInput()\` 清空输入 \n
- \`openPopup()\` 打开弹出框 \n
- \`closePopup()\` 关闭弹出框 \n
- \`filter()\` 使用 \`filterOption\` 过滤选项列表
\n<br/>
\n### 支持的信号：\n
- \`search(input: string)\` 搜索补全项的时发出\n
  - \`input\` 输入文本\n
- \`select(option: var)\` 选择补全项时发出\n
  - \`option\` 选择的选项\n
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
- 需要一个输入框而不是选择器。\n
- 需要输入建议/辅助提示。\n
和 [HusSelect](internal://HusSelect) 的区别是：\n
- [HusAutoComplete](internal://HusAutoComplete) 是一个带提示的文本输入框，用户可以自由输入，关键词是**辅助输入**。\n
- [HusSelect](internal://HusSelect) 是在限定的可选项中进行选择，关键词是**选择**。\n
                       `)
        }

        ThemeToken {
            source: 'HusAutoComplete'
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('基本使用')
            desc: qsTr(`
基本使用，通过 \`options\` 设置自动完成的数据源。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusAutoComplete {
                        width: 180
                        placeholderText: qsTr('input here')
                        onSearch: function(input) {
                            options = input ? [{ label: input.repeat(1) }, { label: input.repeat(2) }, { label: input.repeat(3) }] : [];
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusAutoComplete {
                    width: 180
                    placeholderText: qsTr('input here')
                    onSearch: function(input) {
                        options = input ? [{ label: input.repeat(1) }, { label: input.repeat(2) }, { label: input.repeat(3) }] : [];
                    }
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('自定义选项')
            desc: qsTr(`
可以返回自定义的 \`options\` 的 label。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusAutoComplete {
                        width: 180
                        placeholderText: qsTr('input here')
                        onSearch: function(input) {
                            if (!input || input.includes('@')) {
                                options = [];
                            } else {
                                options = ['gmail.com', '163.com', 'qq.com'].map(
                                            (domain) => ({
                                                             label: \`\${input}@\${domain}\`,
                                                             value: \`\${input}@\${domain}\`,
                                                         }));
                            }
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusAutoComplete {
                    width: 180
                    placeholderText: qsTr('input here')
                    onSearch: function(input) {
                        if (!input || input.includes('@')) {
                            options = [];
                        } else {
                            options = ['gmail.com', '163.com', 'qq.com'].map(
                                        (domain) => ({
                                                         label: `${input}@${domain}`,
                                                         value: `${input}@${domain}`,
                                                     }));
                        }
                    }
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('不区分大小写')
            desc: qsTr(`
不区分大小写的 HusAutoComplete。\n
通过 \`filterOption\` 设置过滤选项，它是形如：\`function(input: string, option: var): bool { }\` 的函数。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusAutoComplete {
                        width: 180
                        placeholderText: qsTr('try to type \`b\`')
                        options: [
                            { label: 'Burns Bay Road' },
                            { label: 'Downing Street' },
                            { label: 'Wall Street' },
                        ]
                        filterOption: (input, option) => option.label.toUpperCase().indexOf(input.toUpperCase()) !== -1
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusAutoComplete {
                    width: 180
                    placeholderText: qsTr('try to type `b`')
                    options: [
                        { label: 'Burns Bay Road' },
                        { label: 'Downing Street' },
                        { label: 'Wall Street' },
                    ]
                    filterOption: (input, option) => option.label.toUpperCase().indexOf(input.toUpperCase()) !== -1
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('查询模式 - 确定类目')
            desc: qsTr(`
查询模式: 确定类目 示例。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusAutoComplete {
                        width: 280
                        tooltipVisible: true
                        placeholderText: qsTr('input here')
                        options: [
                            { label: 'HuskarUI', option: 'Libraries' },
                            { label: 'HuskarUI for Qml' },
                            { label: 'HuskarUI FAQ', option: 'Solutions' },
                            { label: 'HuskarUI for Qml FAQ' },
                            { label: 'HuskarUI', option: 'Copyright' },
                            { label: 'Copyright (C) 2025 mengps. All rights reserved.' },
                        ]
                        labelDelegate: Column {
                            id: delegateColumn

                            property string option: modelData.option ?? ''

                            Loader {
                                active: delegateColumn.option !== ''
                                sourceComponent: HusDivider {
                                    width: delegateColumn.width
                                    height: 30
                                    titleAlign: HusDivider.Align_Center
                                    title: delegateColumn.option
                                    colorText: 'red'
                                }
                            }

                            HusText {
                                id: label
                                text: textData
                                color: HusTheme.HusAutoComplete.colorItemText
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        labelBgDelegate: Item {
                            property string option: modelData.option ?? ''

                            Rectangle {
                                width: parent.width
                                height: option == '' ? parent.height : parent.height - 30
                                anchors.bottom: parent.bottom
                                clip: true
                                radius: 2
                                color: highlighted ? HusTheme.HusAutoComplete.colorItemBgActive :
                                                     hovered ? HusTheme.HusAutoComplete.colorItemBgHover :
                                                               HusTheme.HusAutoComplete.colorItemBg;
                            }
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusAutoComplete {
                    width: 280
                    tooltipVisible: true
                    placeholderText: qsTr('input here')
                    options: [
                        { label: 'HuskarUI', option: 'Libraries' },
                        { label: 'HuskarUI for Qml' },
                        { label: 'HuskarUI FAQ', option: 'Solutions' },
                        { label: 'HuskarUI for Qml FAQ' },
                        { label: 'HuskarUI', option: 'Copyright' },
                        { label: 'Copyright (C) 2025 mengps. All rights reserved.' },
                    ]
                    labelDelegate: Column {
                        id: delegateColumn

                        property string option: modelData.option ?? ''

                        Loader {
                            active: delegateColumn.option !== ''
                            sourceComponent: HusDivider {
                                width: delegateColumn.width
                                height: 30
                                titleAlign: HusDivider.Align_Center
                                title: delegateColumn.option
                                colorText: 'red'
                            }
                        }

                        HusText {
                            id: label
                            text: textData
                            color: HusTheme.HusAutoComplete.colorItemText
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    labelBgDelegate: Item {
                        property string option: modelData.option ?? ''

                        Rectangle {
                            width: parent.width
                            height: option == '' ? parent.height : parent.height - 30
                            anchors.bottom: parent.bottom
                            clip: true
                            radius: 2
                            color: highlighted ? HusTheme.HusAutoComplete.colorItemBgActive :
                                                 hovered ? HusTheme.HusAutoComplete.colorItemBgHover :
                                                           HusTheme.HusAutoComplete.colorItemBg;
                        }
                    }
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('查询模式 - 不确定类目')
            desc: qsTr(`
查询模式: 不确定类目 示例。\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: -8

                    HusAutoComplete {
                        width: 280
                        height: 40
                        rightPadding: 20
                        tooltipVisible: true
                        placeholderText: qsTr('input here')
                        onSearch: function(input) {
                            if (!input) {
                                options = [];
                            } else {
                                const getRandomInt = (max, min = 0) => Math.floor(Math.random() * (max - min + 1)) + min;
                                options =
                                        Array.from({ length: getRandomInt(5) })
                                            .join('.')
                                            .split('.')
                                            .map((_, idx) => {
                                                     const category = \`\${input}\${idx}\`;
                                                     return {
                                                         value: category,
                                                         label: \`Found \${input} on <span style='color:#1677FF'>\${category}</span> \${getRandomInt(200, 100)} results\`
                                                     }
                                                 });
                            }
                        }
                        labelDelegate: HusText {
                            text: textData
                            color: HusTheme.HusAutoComplete.colorItemText
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                            textFormat: Text.RichText
                        }
                    }

                    HusIconButton {
                        id: searchButton
                        height: 40
                        type: HusButton.Type_Primary
                        iconSource: HusIcon.SearchOutlined
                        background: HusRectangle {
                            topLeftRadius: 0
                            bottomLeftRadius: 0
                            topRightRadius: searchButton.radiusBg
                            bottomRightRadius: searchButton.radiusBg
                            color: searchButton.colorBg
                            border.color: searchButton.colorBorder
                            border.width: 1
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: -8

                HusAutoComplete {
                    width: 280
                    height: 40
                    rightPadding: 20
                    tooltipVisible: true
                    placeholderText: qsTr('input here')
                    onSearch: function(input) {
                        if (!input) {
                            options = [];
                        } else {
                            const getRandomInt = (max, min = 0) => Math.floor(Math.random() * (max - min + 1)) + min;
                            options =
                                    Array.from({ length: getRandomInt(5) })
                                        .join('.')
                                        .split('.')
                                        .map((_, idx) => {
                                                 const category = `${input}${idx}`;
                                                 return {
                                                     value: category,
                                                     label: `Found ${input} on <span style='color:#1677FF'>${category}</span> ${getRandomInt(200, 100)} results`
                                                 }
                                             });
                        }
                    }
                    labelDelegate: HusText {
                        text: textData
                        color: HusTheme.HusAutoComplete.colorItemText
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        textFormat: Text.RichText
                    }
                }

                HusIconButton {
                    id: searchButton
                    height: 40
                    type: HusButton.Type_Primary
                    iconSource: HusIcon.SearchOutlined
                    background: HusRectangle {
                        topLeftRadius: 0
                        bottomLeftRadius: 0
                        topRightRadius: searchButton.radiusBg
                        bottomRightRadius: searchButton.radiusBg
                        color: searchButton.colorBg
                        border.color: searchButton.colorBorder
                        border.width: 1
                    }
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('自定义清除按钮')
            desc: qsTr(`
通过 \`clearEnabled\` 设置是否启用清除按钮。\n
通过 \`iconSource\` 设置清除图标，设置为 0 则不显示。\n
通过 \`iconSize\` 设置清除图标大小，设置为 0 则不显示。\n
通过 \`iconPosition\` 设置清除图标的位置，支持的位置：\n
- 图标在输入框左边(默认){ HusAutoComplete.Position_Left }\n
- 图标在输入框右边{ HusAutoComplete.Position_Right }\n
                       `)
            code: `
                import QtQuick 2.15
                import HuskarUI.Basic 1.0

                Row {
                    spacing: 10

                    HusAutoComplete {
                        width: 240
                        iconSource: HusIcon.CloseSquareFilled
                        placeholderText: qsTr('Customized clear icon')
                        onSearch: function(input) {
                            options = input ? [{ label: input.repeat(1) }, { label: input.repeat(2) }, { label: input.repeat(3) }] : [];
                        }
                    }
                }
            `
            exampleDelegate: Row {
                spacing: 10

                HusAutoComplete {
                    width: 240
                    iconSource: HusIcon.CloseSquareFilled
                    placeholderText: qsTr('Customized clear icon')
                    onSearch: function(input) {
                        options = input ? [{ label: input.repeat(1) }, { label: input.repeat(2) }, { label: input.repeat(3) }] : [];
                    }
                }
            }
        }
    }
}

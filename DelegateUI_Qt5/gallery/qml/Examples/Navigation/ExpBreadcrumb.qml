import QtQuick 2.15
import QtQuick.Controls 2.15
import DelegateUI 1.0

import '../../Controls'

Flickable {
    contentHeight: column.height
    ScrollBar.vertical: DelScrollBar { }

    Column {
        id: column
        width: parent.width - 15
        spacing: 30

        Description {
            desc: qsTr(`
## DelBreadcrumb 面包屑\n
显示当前页面在系统层级结构中的位置，并能向上返回。\n
* **继承自 { Item }**\n
支持的代理：\n
- **itemDelegate: Component** 路由项代理，代理可访问属性：\n
  - \`index: int\` 当前项索引\n
  - \`model: var\` 当前项数据\n
  - \`isCurrent: bool\` 是否为当前路由\n
- **separatorDelegate: Component** 分隔符代理，代理可访问属性：\n
  - \`index: int\` 当前项索引\n
  - \`model: var\` 当前项数据\n
  - \`isCurrent: bool\` 是否为当前路由\n
支持的属性：\n
属性名 | 类型 | 默认值 | 描述 |
------ | --- | :---: | ---
animationEnabled | bool | true | 是否开启动画
initModel | list | [] | 初始模型
separator | string | '/' | 默认分隔符
spacing | int | 4 | 路由项间隔
titleFont | font | - | 路由项标题字体
defaultIconSize | int | - | 默认图标大小
defaultMenuWidth | int | 120 | 默认菜单宽度
radiusBgItem | int | 4 | 路由项的背景半径
\n模型支持的属性：\n
属性名 | 类型 | 可选/必选 | 描述 |
------ | --- | :---: | ---
title | string | 必选 | 标题
key | string | 可选 | 路由键(最好唯一)
iconSource | int | 可选 | 本路由项图标源(来自DelIcon)
iconUrl | url | 可选 | 本路由项链接
iconSize | int | 可选 | 本路由项图标大小
loading | bool | 可选 | 本路由项是否加载中
separator | string | 可选 | 本路由项分隔符
itemDelegate | var | 可选 | 本路由项图标代理(将覆盖默认itemDelegate)
separatorDelegate | var | 可选 | 本路由项分隔符代理(将覆盖默separatorDelegate)
menu | object | 可选 | 本路由项菜单
\n路由项菜单支持的属性：\n
属性名 | 类型 | 可选/必选 | 描述 |
------ | --- | :---: | ---
width | string | 可选 | 菜单宽度
items | list | 可选 | 菜单模型
\n支持的函数：\n
- \`Object get(index: int)\` 获取 \`index\` 处的模型数据 \n
- \`set(index: int, object: Object)\` 设置 \`index\` 处的模型数据为 \`object\` \n
- \`setProperty(index: int, propertyName: string, value: any)\` 设置 \`index\` 处的模型数据属性名 \`propertyName\` 值为 \`value\` \n
- \`move(from: int, to: int, count: int = 1)\` 将 \`count\` 个模型数据从 \`from\` 位置移动到 \`to\` 位置 \n
- \`insert(index: int, object: Object)\` 插入标签 \`object\` 到 \`index\` 处 \n
- \`append(object: Object)\` 在末尾添加标签 \`object\` \n
- \`remove(index: int, count: int = 1)\` 删除 \`index\` 处 \`count\` 个模型数据 \n
- \`clear()\` 清空所有模型数据 \n
- \`string getPath()\` 获取当前路由路径 \n
\n支持的信号：\n
- \`click(index: int, data: var)\` 点击路由项时发出\n
  - \`index\` 路由项索引\n
  - \`data\` 路由项数据\n
- \`clickMenu(deep: int, menuKey: string, menuData: var)\` 点击路由-菜单项时发出\n
  - \`deep\` 菜单项深度\n
  - \`menuKey\` 菜单项的键\n
  - \`menuData\` 菜单项数据\n
                       `)
        }

        Description {
            title: qsTr('何时使用')
            desc: qsTr(`
- 当系统拥有超过两级以上的层级结构时；
- 当需要告知用户『你在哪里』时；
- 当需要向上导航的功能时。
                       `)
        }

        Description {
            title: qsTr('代码演示')
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('基本')
            desc: qsTr(`
最简单的用法。
                       `)
            code: `
                import QtQuick 2.15
                import DelegateUI 1.0

                Column {
                    width: parent.width
                    spacing: 10

                    DelButton {
                        text: 'Reset'
                        type: DelButton.Type_Primary
                        onClicked: breadcrumb.reset();
                    }

                    DelBreadcrumb {
                        id: breadcrumb
                        width: parent.width
                        initModel: [
                            { title: 'Home' },
                            { title: 'Application Center' },
                            { title: 'Application List' },
                            { title: 'An Application', },
                        ]
                        onClick: (index, data) => remove(index + 1, count - index - 1);
                    }
                }
            `
            exampleDelegate: Column {
                spacing: 10

                DelButton {
                    text: 'Reset'
                    type: DelButton.Type_Primary
                    onClicked: breadcrumb.reset();
                }

                DelBreadcrumb {
                    id: breadcrumb
                    width: parent.width
                    initModel: [
                        { title: 'Home' },
                        { title: 'Application Center' },
                        { title: 'Application List' },
                        { title: 'An Application', },
                    ]
                    onClick: (index, data) => remove(index + 1, count - index - 1);
                }
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('带有图标的')
            desc: qsTr(`
通过 \`iconSource\` 将图标放在文字前面, 如果设置了 \`loading\`, 则显示为加载中。
                       `)
            code: `
                import QtQuick 2.15
                import DelegateUI 1.0

                DelBreadcrumb {
                    width: parent.width
                    initModel: [
                        { iconSource: DelIcon.HomeOutlined },
                        { iconSource: DelIcon.UserOutlined, title: 'Application List' },
                        { loading: true, title: 'Application', },
                    ]
                }
            `
            exampleDelegate: DelBreadcrumb {
                initModel: [
                    { iconSource: DelIcon.HomeOutlined },
                    { iconSource: DelIcon.UserOutlined, title: 'Application List' },
                    { loading: true, title: 'Application', },
                ]
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('分隔符')
            desc: qsTr(`
通过 \`separator\` 属性设置分隔符。
                       `)
            code: `
                import QtQuick 2.15
                import DelegateUI 1.0

                DelBreadcrumb {
                    width: parent.width
                    separator: '>'
                    initModel: [
                        { title: 'Home' },
                        { title: 'Application Center' },
                        { title: 'Application List' },
                        { title: 'An Application', },
                    ]
                }
            `
            exampleDelegate: DelBreadcrumb {
                separator: '>'
                initModel: [
                    { title: 'Home' },
                    { title: 'Application Center' },
                    { title: 'Application List' },
                    { title: 'An Application', },
                ]
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('独立的分隔符')
            desc: qsTr(`
通过 \`model.separator\` 属性自定义单独的分隔符。
                       `)
            code: `
                import QtQuick 2.15
                import DelegateUI 1.0

                DelBreadcrumb {
                    width: parent.width
                    initModel: [
                        { title: 'Location', separator: ':' },
                        { title: 'Application Center' },
                        { title: 'Application List' },
                        { title: 'An Application', },
                    ]
                }
            `
            exampleDelegate: DelBreadcrumb {
                initModel: [
                    { title: 'Location', separator: ':' },
                    { title: 'Application Center' },
                    { title: 'Application List' },
                    { title: 'An Application', },
                ]
            }
        }

        CodeBox {
            width: parent.width
            descTitle: qsTr('带下拉菜单的面包屑')
            desc: qsTr(`
面包屑支持下拉菜单。\n
通过 \`model.menu\` 属性设置为菜单即 [DelContextMenu](internal://DelContextMenu)。\n
通过 \`model.menu.items\` 属性设置菜单列表{即 \`DelContextMenu\` 的 \`initModel\` }。\n
通过 \`model.menu.width\` 属性设置菜单的宽度：\n
                       `)
            code: `
                import QtQuick 2.15
                import DelegateUI 1.0

                DelBreadcrumb {
                    width: parent.width
                    initModel: [
                        { title: 'DelegateUI'  },
                        { title: 'Component' },
                        {
                            title: 'General',
                            menu: {
                                items: [
                                    { label: 'General' },
                                    { label: 'Layout' },
                                    { label: 'Navigation' },
                                ]
                            }
                        },
                        { title: 'Button' },
                    ]
                }
            `
            exampleDelegate: DelBreadcrumb {
                initModel: [
                    { title: 'DelegateUI'  },
                    { title: 'Component' },
                    {
                        title: 'General',
                        menu: {
                            items: [
                                { label: 'General' },
                                { label: 'Layout' },
                                { label: 'Navigation' },
                            ]
                        }
                    },
                    { title: 'Button' },
                ]
            }
        }
    }
}

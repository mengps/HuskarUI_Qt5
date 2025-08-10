import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import HuskarUI.Basic 1.0

Rectangle {
    color: '#80000000'

    ShaderEffect {
        anchors.fill: parent
        vertexShader: 'qrc:/Gallery/shaders/effect1.vert'
        fragmentShader: 'qrc:/Gallery/shaders/effect1.frag'
        opacity: 0.5

        property vector3d iResolution: Qt.vector3d(width, height, 0)
        property real iTime: 0

        Timer {
            running: true
            repeat: true
            interval: 10
            onTriggered: parent.iTime += 0.01;
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: column.height + 20
        ScrollBar.vertical: HusScrollBar { }

        component Shadow: DropShadow {
            id: __dropShadow
            anchors.fill: __rect
            radius: 8
            color: HusTheme.Primary.colorTextBase
            source: __rect
            opacity: parent.hovered ? 0.5 : 0.2

            property int shadowHorizontalOffset: __dropShadow.horizontalOffset
            property int shadowVerticalOffset: __dropShadow.verticalOffset

            Behavior on color { ColorAnimation { duration: HusTheme.Primary.durationMid } }
            Behavior on opacity { NumberAnimation { duration: HusTheme.Primary.durationMid } }
        }

        component Card: MouseArea {
            id: __cardComp
            width: 300
            height: 200
            scale: hovered ? 1.01 : 1
            hoverEnabled: true
            onEntered: hovered = true;
            onExited: hovered = false;
            onClicked: {
                if (__cardComp.link.length != 0)
                    Qt.openUrlExternally(link);
            }

            property bool hovered: false
            property alias icon: __icon
            property alias title: __title
            property alias desc: __desc
            property alias linkIcon: __linkIcon
            property string link: ''
            property bool isNew: false
            property alias newVisible: __new.visible

            Behavior on scale { NumberAnimation { duration: HusTheme.Primary.durationFast } }

            Shadow {
                anchors.fill: __rect
                color: HusTheme.Primary.colorTextBase
                source: __rect
                opacity: parent.hovered ? 0.8 : 0.4

                Behavior on color { ColorAnimation { duration: HusTheme.Primary.durationMid } }
                Behavior on opacity { NumberAnimation { duration: HusTheme.Primary.durationMid } }
            }

            Rectangle {
                id: __rect
                anchors.fill: parent
                color: HusThemeFunctions.alpha(HusTheme.Primary.colorBgBase, 0.8)
                radius: 6
                border.color: HusThemeFunctions.alpha(HusTheme.Primary.colorTextBase, 0.2)

                Behavior on color { ColorAnimation { duration: HusTheme.Primary.durationMid } }
            }

            ColumnLayout {
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                spacing: 10

                HusIconText {
                    id: __icon
                    Layout.preferredWidth: width
                    Layout.preferredHeight: iconSource == 0 ? 0 : height
                    Layout.alignment: Qt.AlignHCenter
                    iconSize: 60
                }

                HusText {
                    id: __title
                    Layout.preferredWidth: parent.width - 10
                    Layout.preferredHeight: height
                    Layout.alignment: Qt.AlignHCenter
                    font {
                        family: HusTheme.Primary.fontPrimaryFamily
                        pixelSize: HusTheme.Primary.fontPrimarySizeHeading4
                        bold: true
                    }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAnywhere
                }

                Flickable {
                    Layout.preferredWidth: parent.width - 50
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    contentHeight: __desc.contentHeight
                    ScrollBar.vertical: HusScrollBar { }
                    clip: true
                    interactive: false

                    HusText {
                        id: __desc
                        width: parent.width - 10
                        font {
                            family: HusTheme.Primary.fontPrimaryFamily
                            pixelSize: HusTheme.Primary.fontPrimarySize
                        }
                        wrapMode: Text.WrapAnywhere
                    }
                }
            }

            Shadow {
                anchors.fill: __new
                shadowHorizontalOffset: 4
                shadowVerticalOffset: 4
                color: __new.color
                source: __new
                opacity: 0.6
                visible: __new.visible
            }

            Rectangle {
                id: __new
                width: __row.width + 12
                height: __row.height + 6
                anchors.right: parent.right
                anchors.rightMargin: -width * 0.2
                anchors.top: parent.top
                anchors.topMargin: 5
                radius: 2
                color: __cardComp.isNew ? HusTheme.Primary.colorError : HusTheme.Primary.colorSuccess

                Row {
                    id: __row
                    anchors.centerIn: parent

                    HusIconText {
                        anchors.verticalCenter: parent.verticalCenter
                        iconSize: HusTheme.Primary.fontPrimarySize
                        iconSource: HusIcon.FireFilled
                        color: 'white'
                    }

                    HusText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: __cardComp.isNew ? 'NEW' : 'UPDATE'
                        font {
                            family: HusTheme.Primary.fontPrimaryFamily
                            pixelSize: HusTheme.Primary.fontPrimarySize
                        }
                        color: 'white'
                    }
                }
            }

            HusIconText {
                id: __linkIcon
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 10
                iconSize: 20
                iconSource: HusIcon.LinkOutlined
            }
        }

        component MyText: HusText {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: column
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 30

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Item {
                    width: HusTheme.Primary.fontPrimarySize + 42
                    height: width
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: huskaruiIcon
                        width: parent.width
                        height: width
                        anchors.centerIn: parent
                        source: 'qrc:/Gallery/images/huskarui_icon.svg'
                    }

                    Shadow {
                        anchors.fill: huskaruiIcon
                        shadowHorizontalOffset: 4
                        shadowVerticalOffset: 4
                        color: '#C44545'
                        source: huskaruiIcon
                        opacity: 0.6

                        Behavior on color { ColorAnimation { duration: HusTheme.Primary.durationMid } }
                        Behavior on opacity { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                    }
                }

                Item {
                    width: huskaruiTitle.width
                    height: huskaruiTitle.height
                    anchors.verticalCenter: parent.verticalCenter

                    MyText {
                        id: huskaruiTitle
                        text: qsTr('HuskarUI')
                        font.pixelSize: HusTheme.Primary.fontPrimarySize + 42
                    }

                    Shadow {
                        anchors.fill: huskaruiTitle
                        shadowHorizontalOffset: 4
                        shadowVerticalOffset: 4
                        color: huskaruiTitle.color
                        source: huskaruiTitle
                        opacity: 0.6

                        Behavior on color { ColorAnimation { duration: HusTheme.Primary.durationMid } }
                        Behavior on opacity { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                    }
                }
            }

            MyText {
                text: qsTr('助力开发者「更灵活」地搭建出「更美」的产品，让用户「快乐工作」～')
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Card {
                    icon.iconSource: HusIcon.GithubOutlined
                    title.text: qsTr('HuskarUI Github')
                    desc.text: qsTr('HuskarUI 是遵循「Ant Design」设计体系的一个 Qml UI 库，用于构建由「Qt Quick」驱动的用户界面。')
                    link: 'https://github.com/mengps/HuskarUI'
                    newVisible: false
                }
            }

            MyText {
                text: qsTr('定制主题，随心所欲')
                font.pixelSize: HusTheme.Primary.fontPrimarySize + 16
                font.bold: true
            }

            MyText {
                text: qsTr('HuskarUI 支持全局/组件的样式定制，内置多种接口让你定制主题更简单')
            }

            Card {
                anchors.horizontalCenter: parent.horizontalCenter
                icon.iconSource: HusIcon.SkinOutlined
                title.text: qsTr('HuskarUI-ThemeDesigner')
                desc.text: qsTr('HuskarUI-ThemeDesigner 是专为「HuskarUI」打造的主题设计工具。')
                link: 'https://github.com/mengps/HuskarUI-ThemeDesigner'
                newVisible: false
            }

            MyText {
                text: qsTr('组件丰富，选用自如')
                font.pixelSize: HusTheme.Primary.fontPrimarySize + 16
                font.bold: true
            }

            MyText {
                text: qsTr('HuskarUI 提供大量实用组件满足你的需求，基于代理的方式实现灵活定制与拓展')
            }

            ListView {
                id: newView
                width: parent.width
                height: 200
                orientation: Qt.Horizontal
                spacing: -80
                model: ListModel { id: listModel }
                Component.onCompleted: {
                    const updates = HusApi.readFileToString(':/Gallery/UpdateLists.json');
                    let object = JSON.parse(updates);
                    for (const o of object)
                        listModel.append(o);
                }
                delegate: Item {
                    id: __rootItem
                    z: index
                    width: __card.hovered ? 390 : 250
                    height: newView.height - 30
                    required property int index
                    required property bool isNew
                    required property string name
                    required property string desc

                    property bool preventFlicker: false

                    Behavior on width { NumberAnimation { duration: HusTheme.Primary.durationMid } }

                    MouseArea {
                        id: hoverArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.NoButton
                        
                        onEntered: {
                            if (!__card.hovered) {
                                __card.hovered = true;
                                preventFlicker = true;
                                flickerTimer.restart();
                            }
                        }
                        
                        onExited: {
                            if (!__card.containsMouse) {
                                __card.hovered = false;
                            }
                        }
                    }
                    
                    Timer {
                        id: flickerTimer
                        interval: HusTheme.Primary.durationMid * 1.5
                        onTriggered: {
                            __rootItem.preventFlicker = false;
                        }
                    }
                    
                    Connections {
                        target: __card
                        function onContainsMouseChanged() {
                            if (__card.containsMouse) {
                                __card.hovered = true;
                            }
                        }
                    }

                    Card {
                        id: __card
                        width: 250
                        height: parent.height
                        anchors.centerIn: parent
                        title.text: __rootItem.name
                        desc.text: __rootItem.desc
                        isNew: __rootItem.isNew
                        transform: Rotation {
                            origin.x: __rootItem.width * 0.5
                            origin.y: __rootItem.height * 0.5
                            axis {
                                x: 0
                                y: 1
                                z: 0
                            }
                            angle: __card.hovered ? 0 : 45

                            Behavior on angle { NumberAnimation { duration: HusTheme.Primary.durationMid } }
                        }
                        onClicked: {
                            galleryMenu.gotoMenu(__rootItem.name);
                        }
                    }
                }

                ScrollBar.horizontal: HusScrollBar { }
            }
        }
    }
}


import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import DelegateUI 1.0

DelWindow {
    id: root
    width: 400
    height: 500
    minimumWidth: 400
    minimumHeight: 500
    captionBar.minimizeButtonVisible: false
    captionBar.maximizeButtonVisible: false
    captionBar.winTitle: qsTr("关于")
    captionBar.winIconDelegate: Item {
        DelIconText {
            iconSize: 22
            colorIcon: "#C44545"
            font.bold: true
            iconSource: DelIcon.DelegateUIPath1
        }
        DelIconText {
            iconSize: 22
            colorIcon: "#C44545"
            font.bold: true
            iconSource: DelIcon.DelegateUIPath2
        }
    }
    captionBar.closeCallback: () => aboutLoader.visible = false;

    Item {
        anchors.fill: parent

        DropShadow {
            anchors.fill: backRect
            radius: 8.0
            samples: 17
            color: DelTheme.Primary.colorTextBase
            source: backRect
        }

        Rectangle {
            id: backRect
            anchors.fill: parent
            radius: 6
            color: DelTheme.Primary.colorBgBase
            border.color: DelThemeFunctions.alpha(DelTheme.Primary.colorTextBase, 0.2)
        }

        Item {
            anchors.fill: parent

            ShaderEffect {
                anchors.fill: parent
                vertexShader: "qrc:/Gallery/shaders/effect2.vert"
                fragmentShader: "qrc:/Gallery/shaders/effect2.frag"
                opacity: 0.5

                property vector3d iResolution: Qt.vector3d(width, height, 0)
                property real iTime: 0

                Timer {
                    running: true
                    repeat: true
                    interval: 10
                    onTriggered: parent.iTime += 0.03;
                }
            }
        }

        Column {
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: captionBar.height
            spacing: 10

            Item {
                width: 80
                height: width
                anchors.horizontalCenter: parent.horizontalCenter

                DelIconText {
                    iconSize: parent.width
                    colorIcon: "#C44545"
                    font.bold: true
                    iconSource: DelIcon.DelegateUIPath1
                }

                DelIconText {
                    iconSize: parent.width
                    colorIcon: "#C44545"
                    font.bold: true
                    iconSource: DelIcon.DelegateUIPath2
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    family: DelTheme.Primary.fontPrimaryFamily
                    pixelSize: DelTheme.Primary.fontPrimarySizeHeading3
                    bold: true
                }
                color: DelTheme.Primary.colorTextBase
                text: "DelegateUI Gallery"
            }

            DelCopyableText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("库版本: ") + DelApp.libVersion()
            }

            DelCopyableText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("作者: MenPenS")
            }

            DelCopyableText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("微信号: MenPenS0612")
            }

            DelCopyableText {
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: DelCopyableText.WordWrap
                horizontalAlignment: DelCopyableText.AlignHCenter
                text: qsTr("QQ交流群号: <a href=\"https://qm.qq.com/q/cMNHn2tWeY\" style=\"color:#722ED1\">490328047</a>")
                textFormat: DelCopyableText.RichText
                onLinkActivated: (link) => Qt.openUrlExternally(link);
            }

            DelCopyableText {
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: DelCopyableText.WordWrap
                horizontalAlignment: DelCopyableText.AlignHCenter
                text: "Github: <a href=\"https://github.com/mengps/DelegateUI\" style=\"color:#722ED1\">https://github.com/mengps/DelegateUI</a>"
                textFormat: DelCopyableText.RichText
                onLinkActivated: (link) => Qt.openUrlExternally(link);
            }

            DelCopyableText {
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: DelCopyableText.WordWrap
                horizontalAlignment: DelCopyableText.AlignHCenter
                text: qsTr("如果该项目/源码对你有用，就请点击上方链接给一个免费的Star，谢谢！")
            }

            DelCopyableText {
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: DelCopyableText.WordWrap
                horizontalAlignment: DelCopyableText.AlignHCenter
                text: qsTr("有任何问题可以提Issues或进群！")
            }
        }
    }
}

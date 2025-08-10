import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Templates 2.15 as T
import HuskarUI.Basic 1.0

T.Drawer {
    id: control

    property bool animationEnabled: HusTheme.animationEnabled
    property int drawerSize: 378
    property string title: ''
    property font titleFont
    property color colorTitle: HusTheme.HusDrawer.colorTitle
    property color colorBg: HusTheme.HusDrawer.colorBg
    property color colorOverlay: HusTheme.HusDrawer.colorOverlay
    property Component titleDelegate: Item {
        height: 56

        Row {
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 15
            spacing: 5

            HusCaptionButton {
                id: __close
                topPadding: 2
                bottomPadding: 2
                leftPadding: 4
                rightPadding: 4
                radiusBg: 4
                anchors.verticalCenter: parent.verticalCenter
                iconSource: HusIcon.CloseOutlined
                hoverCursorShape: Qt.PointingHandCursor
                onClicked: {
                    control.close();
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: control.title
                font: control.titleFont
                color: control.colorTitle
            }
        }

        HusDivider {
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }
    property Component contentDelegate: Item { }

    enter: Transition { NumberAnimation { duration: control.animationEnabled ? HusTheme.Primary.durationMid : 0 } }
    exit: Transition { NumberAnimation { duration: control.animationEnabled ? HusTheme.Primary.durationMid : 0 } }

    width: edge === Qt.LeftEdge || edge === Qt.RightEdge ? drawerSize : parent.width
    height: edge === Qt.LeftEdge || edge === Qt.RightEdge ? parent.height : drawerSize
    titleFont {
        family: HusTheme.HusDrawer.fontFamily
        pixelSize: HusTheme.HusDrawer.fontSizeTitle
    }
    edge: Qt.RightEdge
    parent: T.Overlay.overlay
    modal: true
    background: Item {
        DropShadow {
            anchors.fill: __rect
            radius: 16
            samples: 17
            color: HusThemeFunctions.alpha(HusTheme.HusDrawer.colorShadow, HusTheme.isDark ? 0.1 : 0.2)
            source: __rect
        }

        Rectangle {
            id: __rect
            anchors.fill: parent
            color: control.colorBg
        }
    }
    contentItem: ColumnLayout {
        Loader {
            Layout.fillWidth: true
            sourceComponent: titleDelegate
            onLoaded: {
                /*! 无边框窗口的标题栏会阻止事件传递, 需要调这个 */
                if (captionBar)
                    captionBar.addInteractionItem(item);
            }
        }
        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: contentDelegate
        }
    }

    T.Overlay.modal: Rectangle {
        color: control.colorOverlay
    }
}

import QtQuick 2.15
import HuskarUI.Basic 1.0

Image {
    id: control

    property bool animationEnabled: HusTheme.animationEnabled
    property bool previewEnabled: true
    readonly property alias hovered: __hoverHandler.hovered
    property int hoverCursorShape: Qt.PointingHandCursor
    property url fallback: ''
    property url placeholder: ''
    property var items: []

    objectName: '__HusImage__'
    onSourceChanged: {
        if (items.length == 0) {
            __private.previewItems = [{ url: source }];
        }
    }
    onItemsChanged: {
        if (items.length > 0) {
            __private.previewItems = [...items];
        }
    }

    QtObject {
        id: __private
        property var previewItems: []
    }

    Loader {
        anchors.centerIn: parent
        active: control.status == Image.Error && control.fallback != ''
        sourceComponent: Image {
            source: control.fallback
            Component.onCompleted: {
                __private.previewItems = [{ url: control.fallback }]
            }
        }
    }

    Loader {
        anchors.centerIn: parent
        active: control.status == Image.Loading && control.placeholder != ''
        sourceComponent: Image {
            source: control.placeholder
        }
    }

    Loader {
        anchors.fill: parent
        active: control.previewEnabled
        sourceComponent: Rectangle {
            color: HusTheme.Primary.colorTextTertiary
            opacity: control.hovered ? 1.0 : 0.0

            Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationMid } }
            Behavior on opacity { enabled: control.animationEnabled; NumberAnimation { duration: HusTheme.Primary.durationMid } }

            Row {
                anchors.centerIn: parent
                spacing: 5

                HusIconText {
                    anchors.verticalCenter: parent.verticalCenter
                    colorIcon: HusTheme.HusImage.colorText
                    iconSource: HusIcon.EyeOutlined
                    iconSize: HusTheme.HusImage.fontSize + 2
                }

                HusText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr('预览')
                    color: HusTheme.HusImage.colorText
                }
            }

            HusImagePreview {
                id: __preview
                animationEnabled: control.animationEnabled
                items: __private.previewItems
            }

            TapHandler {
                onTapped: {
                    if (!__preview.opened) {
                        __preview.open();
                    }
                }
            }
        }
    }

    HoverHandler {
        id: __hoverHandler
        cursorShape: control.hoverCursorShape
    }
}

import QtQuick 2.15
import QtGraphicalEffects 1.15
import HuskarUI.Basic 1.0

Item {
    id: control

    enum TextSiz {
        Size_Fixed = 0,
        Size_Auto = 1
    }

    property int size: 30
    property int iconSource: 0

    property url imageSource: ''
    property bool imageMipmap: false

    property string textSource: ''
    property font textFont: Qt.font({
                                        family: HusTheme.Primary.fontPrimaryFamily,
                                        pixelSize: control.size * 0.5
                                    })
    property int textSize: HusAvatar.Size_Fixed
    property int textGap: 4

    property color colorBg: HusTheme.Primary.colorTextQuaternary
    property color colorIcon: 'white'
    property color colorText: 'white'
    property int radiusBg: width * 0.5

    objectName: '__HusAvatar__'
    width: __loader.width
    height: __loader.height

    Component {
        id: __iconImpl

        Rectangle {
            width: control.size
            height: control.size
            radius: control.radiusBg
            color: control.colorBg

            HusIconText {
                id: __iconSource
                anchors.centerIn: parent
                iconSource: control.iconSource
                iconSize: control.size * 0.7
                colorIcon: control.colorIcon
            }
        }
    }

    Component {
        id: __imageImpl

        Rectangle {
            width: control.size
            height: control.size
            radius: control.radiusBg
            color: control.colorBg

            Rectangle {
                id: __mask
                anchors.fill: parent
                radius: parent.radius
                layer.enabled: true
                visible: false
            }

            Image {
                id: __imageSource
                anchors.fill: parent
                mipmap: control.imageMipmap
                source: control.imageSource
                sourceSize: Qt.size(width, height)
                layer.enabled: true
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                maskSource: __mask
                source: __imageSource
            }
        }
    }

    Component {
        id: __textImpl

        Rectangle {
            id: __bg
            width: Math.max(control.size, __textSource.implicitWidth + control.textGap * 2);
            height: width
            radius: control.radiusBg
            color: control.colorBg
            Component.onCompleted: calcBestSize();

            function calcBestSize() {
                if (control.textSize == HusAvatar.Size_Fixed) {
                    __textSource.font.pixelSize = control.size * 0.5;
                } else {
                    let bestSize = control.size * 0.5;
                    __fontMetrics.font.pixelSize = bestSize;
                    while ((__fontMetrics.advanceWidth(control.textSource) + control.textGap * 2 > control.size)) {
                        bestSize -= 1;
                        __fontMetrics.font.pixelSize = bestSize;
                        if (bestSize <= 1) break;
                    }
                    __textSource.font.pixelSize = bestSize;
                }
            }

            FontMetrics {
                id: __fontMetrics
                font.family: __textSource.font.family
            }

            Text {
                id: __textSource
                anchors.centerIn: parent
                color: control.colorText
                text: control.textSource
                smooth: true
                font: control.textFont

                Connections {
                    target: control
                    function onTextSourceChanged() {
                        __bg.calcBestSize();
                    }
                }
            }
        }
    }

    Loader {
        id: __loader
        sourceComponent: {
            if (control.iconSource != 0)
                return __iconImpl;
            else if (control.imageSource != '')
                return __imageImpl;
            else
                return __textImpl;
        }
    }
}

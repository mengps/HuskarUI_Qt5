import QtQuick 2.15
import HuskarUI.Basic 1.0

HusIconButton {
    id: control

    property bool isError: false

    objectName: '__HusCaptionButton__'
    leftPadding: 12
    rightPadding: 12
    radiusBg: 0
    hoverCursorShape: Qt.ArrowCursor
    type: HusButton.Type_Text
    iconSize: HusTheme.HusCaptionButton.fontSize
    effectEnabled: false
    colorIcon: {
        if (enabled) {
            return checked ? HusTheme.HusCaptionButton.colorIconChecked :
                             HusTheme.HusCaptionButton.colorIcon;
        } else {
            return HusTheme.HusCaptionButton.colorIconDisabled;
        }
    }
    colorBg: {
        if (enabled) {
            if (isError) {
                return control.down ? HusTheme.HusCaptionButton.colorErrorBgActive:
                                      control.hovered ? HusTheme.HusCaptionButton.colorErrorBgHover :
                                                        HusTheme.HusCaptionButton.colorErrorBg;
            } else {
                return control.down ? HusTheme.HusCaptionButton.colorBgActive:
                                      control.hovered ? HusTheme.HusCaptionButton.colorBgHover :
                                                        HusTheme.HusCaptionButton.colorBg;
            }
        } else {
            return HusTheme.HusCaptionButton.colorBgDisabled;
        }
    }
}

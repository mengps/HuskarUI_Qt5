import QtQuick 2.15
import HuskarUI.Basic 1.0

Text {
    id: control

    objectName: '__HusText__'
    renderType: HusTheme.textRenderType
    color: HusTheme.Primary.colorTextBase
    font {
        family: HusTheme.Primary.fontPrimaryFamily
        pixelSize: HusTheme.Primary.fontPrimarySize
    }
}

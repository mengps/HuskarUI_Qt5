import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import HuskarUI.Basic 1.0

import '../Controls'

HusWindow {
    id: root
    width: 500
    height: 600
    minimumWidth: 500
    minimumHeight: 600
    captionBar.minimizeButtonVisible: false
    captionBar.maximizeButtonVisible: false
    captionBar.winTitle: qsTr('设置')
    captionBar.winIconDelegate: Item {
        Image {
            width: 16
            height: 16
            anchors.centerIn: parent
            source: 'qrc:/Gallery/images/huskarui_icon.svg'
        }
    }
    captionBar.closeCallback: () => settingsLoader.visible = false;

    Item {
        anchors.fill: parent

        DropShadow {
            anchors.fill: backRect
            radius: 8.0
            samples: 17
            color: HusTheme.Primary.colorTextBase
            source: backRect
        }

        Rectangle {
            id: backRect
            anchors.fill: parent
            radius: 6
            color: HusTheme.Primary.colorBgBase
            border.color: HusThemeFunctions.alpha(HusTheme.Primary.colorTextBase, 0.2)
        }

        Item {
            anchors.fill: parent

            ShaderEffect {
                anchors.fill: parent
                vertexShader: 'qrc:/Gallery/shaders/effect2.vert'
                fragmentShader: 'qrc:/Gallery/shaders/effect2.frag'
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
            anchors.top: parent.top
            anchors.topMargin: captionBar.height + 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 20

            MySlider {
                id: themeSpeed
                label.text: qsTr('动画基础速度')
                slider.min: 20
                slider.max: 200
                slider.stepSize: 1
                slider.onFirstReleased: {
                    const base = slider.currentValue;
                    HusTheme.installThemePrimaryAnimationBase(base, base * 2, base * 3);
                }
                slider.handleToolTipDelegate: HusToolTip {
                    arrowVisible: true
                    delay: 100
                    text: themeSpeed.slider.currentValue
                    visible: handlePressed || handleHovered
                }
                Component.onCompleted: {
                    slider.value = HusTheme.Primary.durationFast;
                }
            }

            MySlider {
                id: bgOpacitySlider
                label.text: qsTr('背景透明度')
                slider.value: galleryBackground.opacity
                slider.snapMode: HusSlider.SnapOnRelease
                slider.onFirstMoved: {
                    galleryBackground.opacity = slider.currentValue;
                }
                slider.handleToolTipDelegate: HusToolTip {
                    arrowVisible: true
                    delay: 100
                    text: bgOpacitySlider.slider.currentValue.toFixed(1)
                    visible: handlePressed || handleHovered
                }
            }

            MySlider {
                label.text: qsTr('字体大小')
                slider.min: 12
                slider.max: 24
                slider.stepSize: 4
                slider.value: HusTheme.Primary.fontPrimarySizeHeading5
                slider.snapMode: HusSlider.SnapAlways
                slider.onFirstReleased: {
                    HusTheme.installThemePrimaryFontSizeBase(slider.currentValue);
                }
                scaleVisible: true
            }

            MySlider {
                label.text: qsTr('圆角大小')
                slider.min: 0
                slider.max: 24
                slider.stepSize: 2
                slider.value: HusTheme.Primary.radiusPrimary
                slider.snapMode: HusSlider.SnapAlways
                slider.onFirstReleased: {
                    HusTheme.installThemePrimaryRadiusBase(slider.currentValue);
                }
                scaleVisible: true
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                spacing: 20

                HusText {
                    width: HusTheme.Primary.fontPrimarySize * 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr('应用主题')
                }

                HusSelect {
                    id: darkModeSelect
                    width: 110
                    anchors.verticalCenter: parent.verticalCenter
                    currentIndex: 0
                    model: [
                        { 'label': qsTr('浅色'), 'value': HusTheme.Light },
                        { 'label': qsTr('深色'), 'value': HusTheme.Dark },
                        { 'label': qsTr('跟随系统'), 'value': HusTheme.System }
                    ]
                    onCurrentValueChanged: {
                        if (currentValue === HusTheme.System) {
                            HusTheme.darkMode = HusTheme.System;
                        } else if (currentValue === HusTheme.Dark) {
                            if (HusTheme.isDark) {
                                HusTheme.darkMode = HusTheme.Dark;
                            } else {
                                galleryWindow.captionBar.themeCallback();
                            }
                        } else if (currentValue === HusTheme.Light && HusTheme.isDark) {
                            if (HusTheme.isDark) {
                                galleryWindow.captionBar.themeCallback();
                            } else {
                                HusTheme.darkMode = HusTheme.Light;
                            }
                        }
                    }

                    Connections {
                        target: HusTheme
                        function onDarkModeChanged() {
                            darkModeSelect.currentIndex = HusTheme.darkMode;
                        }
                    }
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                spacing: 20

                HusText {
                    width: HusTheme.Primary.fontPrimarySize * 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr('窗口效果')
                }

                HusSelect {
                    id: effectSelect
                    width: 110
                    anchors.verticalCenter: parent.verticalCenter
                    currentIndex: 0
                    model: [
                        { 'label': qsTr('浅色'), 'value': HusTheme.Light },
                        { 'label': qsTr('深色'), 'value': HusTheme.Dark },
                        { 'label': qsTr('跟随系统'), 'value': HusTheme.System }
                    ]
                    onActivated: {
                        galleryWindow.setSpecialEffect(currentValue);
                    }
                    Component.onCompleted: {
                        if (Qt.platform.os === 'windows'){
                            model = [
                                        { 'label': qsTr('无'), 'value': HusWindow.None },
                                        { 'label': qsTr('模糊'), 'value': HusWindow.Win_DwmBlur },
                                        { 'label': qsTr('亚克力'), 'value': HusWindow.Win_AcrylicMaterial },
                                        { 'label': qsTr('云母'), 'value': HusWindow.Win_Mica },
                                        { 'label': qsTr('云母变体'), 'value': HusWindow.Win_MicaAlt }
                                    ];
                        } else if (Qt.platform.os === 'osx') {
                            model = [
                                        { 'label': qsTr('无'), 'value': HusWindow.None },
                                        { 'label': qsTr('模糊'), 'value': HusWindow.Mac_BlurEffect },
                                    ];
                        }

                        for (let i = 0; i < model.length; i++) {
                            if (galleryWindow.specialEffect === model[i].value) {
                                currentIndex = i;
                                break;
                            }
                        }
                    }

                    Connections {
                        target: galleryWindow
                        function onSpecialEffectChanged() {
                            effectSelect.currentIndex = effectSelect.indexOfValue(galleryWindow.specialEffect);
                        }
                    }
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                spacing: 20

                HusText {
                    width: HusTheme.Primary.fontPrimarySize * 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr('导航模式')
                }

                HusRadioBlock {
                    id: navMode
                    initCheckedIndex: 0
                    model: [
                        { label: '默认', value: false },
                        { label: '紧凑', value: true }
                    ]
                    onClicked:
                        (index, radioData) => {
                            galleryMenu.compactMode = radioData.value;
                        }

                    Connections {
                        target: galleryMenu
                        function onCompactModeChanged() {
                            navMode.currentCheckedIndex = galleryMenu.compactMode ? 1 : 0;
                        }
                    }
                }
            }
        }
    }
}

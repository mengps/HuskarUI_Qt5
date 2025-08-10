import QtQuick 2.15
import QtQuick.Layouts 1.15
import HuskarUI.Basic 1.0

Item {
    id: root

    width: parent.width
    height: column.height

    property string source: ''

    HusPopup {
        id: editPopup

        property int row
        property var edit

        padding: 5
        contentItem: Row {
            spacing: 5

            HusAutoComplete {
                id: editInput
                width: 200
                options: galleryWindow.primaryTokens
                tooltipVisible: true
                iconSource: length > 0 ? HusIcon.CloseCircleFilled : 0
                filterOption: function(input, option){
                    return option.label.toUpperCase().indexOf(input.toUpperCase()) !== -1;
                }
            }

            HusButton {
                text: qsTr('确认')
                onClicked: {
                    editPopup.edit.value = editInput.text;
                    galleryWindow.componentTokens[root.source][editPopup.row].tokenValue.value = editPopup.edit.value;
                    HusTheme.installComponentToken(root.source, editPopup.edit.token, editInput.text);
                    editPopup.close();
                }
            }

            HusButton {
                text: qsTr('取消')
                onClicked: {
                    editPopup.close();
                }
            }

            HusButton {
                text: qsTr('重置')
                onClicked: {
                    editPopup.edit.value = editPopup.edit.rawValue;
                    HusTheme.installComponentToken(root.source, editPopup.edit.token, editPopup.edit.rawValue);
                    editPopup.close();
                }
            }
        }
    }

    Component {
        id: tagDelegate

        Item {
            HusTag {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: cellData
                presetColor: 'orange'
                font {
                    family: HusTheme.Primary.fontPrimaryFamily
                    pixelSize: HusTheme.Primary.fontPrimarySize
                }

                HoverHandler {
                    id: hoverHandler
                }

                HusToolTip {
                    text: parent.text
                    visible: hoverHandler.hovered
                }
            }
        }
    }

    Component {
        id: editDelegate

        Item {
            Row {
                id: editRow
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 5

                property string token: cellData.token
                property string rawValue: cellData.rawValue
                property string value: cellData.value

                HusIconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    iconSource: HusIcon.EditOutlined
                    topPadding: 2
                    bottomPadding: 2
                    leftPadding: 4
                    rightPadding: 4
                    onClicked: {
                        editPopup.parent = this;
                        editPopup.row = row;
                        editPopup.edit = editRow;
                        editInput.text = editRow.value;
                        editInput.filter();
                        editPopup.open();
                    }

                    HusToolTip {
                        visible: parent.hovered
                        text: qsTr('编辑Token')
                    }
                }

                HusTag {
                    anchors.verticalCenter: parent.verticalCenter
                    text: editRow.value
                    presetColor: 'green'
                    font {
                        family: HusTheme.Primary.fontPrimaryFamily
                        pixelSize: HusTheme.Primary.fontPrimarySize
                    }
                    HoverHandler {
                        id: hoverHandler
                    }

                    HusToolTip {
                        text: parent.text
                        visible: hoverHandler.hovered
                    }
                }
            }
        }
    }

    Component {
        id: colorTagDelegate

        Item {
            property var theCellData: HusTheme[root.source][cellData]

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                Rectangle {
                    width: tag.height
                    height: tag.height
                    color: {
                        try {
                            Qt.color(value);
                            return value;
                        } catch (err) {
                            return 'transparent';
                        }
                    }
                    property string value: theCellData
                }

                HusTag {
                    id: tag
                    Layout.leftMargin: 15
                    Layout.alignment: Qt.AlignVCenter
                    text: theCellData
                    presetColor: 'blue'
                    font {
                        family: HusTheme.Primary.fontPrimaryFamily
                        pixelSize: HusTheme.Primary.fontPrimarySize
                    }
                }
            }
        }
    }

    Column {
        id: column
        width: parent.width - 20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        HusText {
            text: qsTr('主题变量（Design Token）')
            width: parent.width
            font {
                pixelSize: HusTheme.Primary.fontPrimarySizeHeading3
                weight: Font.DemiBold
            }
        }

        Loader {
            id: tableLoader
            width: parent.width
            height: 40 * (galleryWindow.componentTokens[root.source].length + 1)
            active: root.source != ''
            asynchronous: true
            sourceComponent: HusTableView {
                propagateWheelEvent: true
                columnGridVisible: true
                columns: [
                    {
                        title: qsTr('Token 名称'),
                        dataIndex: 'tokenName',
                        key: 'tokenName',
                        delegate: tagDelegate,
                        width: 250
                    },
                    {
                        title: qsTr('Token 值'),
                        key: 'tokenValue',
                        dataIndex: 'tokenValue',
                        delegate: editDelegate,
                        width: 400
                    },
                    {
                        title: qsTr('Token 计算值'),
                        key: 'tokenCalcValue',
                        dataIndex: 'tokenCalcValue',
                        delegate: colorTagDelegate,
                        width: 250
                    }
                ]
                Component.onCompleted: {
                    if (root.source != '') {
                        const model = galleryWindow.componentTokens[root.source];
                        height = defaultColumnHeaderHeight + model.length * minimumRowHeight;
                        initModel = model;
                    }
                }
            }
        }
    }
}

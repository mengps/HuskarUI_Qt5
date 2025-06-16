import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import DelegateUI 1.0

Item {
    id: control

    height: 30
    titleFont {
        family: DelTheme.DelBreadcrumb.fontFamily
        pixelSize: DelTheme.DelBreadcrumb.fontSize
    }

    signal click(index: int, data: var)
    signal clickMenu(deep: int, menuKey: string, menuData: var)

    property bool animationEnabled: DelTheme.animationEnabled
    property var initModel: []
    readonly property int count: __listModel.count
    property string separator: '/'
    property int spacing: 4
    property font titleFont
    property int defaultIconSize: DelTheme.DelBreadcrumb.fontSize + 2
    property int defaultMenuWidth: 120
    property int radiusBgItem: 4

    property Component itemDelegate: Rectangle {
        id: __itemDelegate

        implicitWidth: __itemRow.implicitWidth + 8
        implicitHeight: Math.max(__icon.implicitHeight, __text.implicitHeight) + 4
        radius: control.radiusBgItem
        color: isCurrent || !__hoverHandler.hovered ? DelTheme.DelBreadcrumb.colorBgLast :
                                                      DelTheme.DelBreadcrumb.colorBg;

        property int __index: index
        property var menu: model.menu ?? {}
        property var menuItem: menu.items ?? []

        Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: DelTheme.Primary.durationFast } }

        Row {
            id: __itemRow
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            DelIconText {
                id: __icon
                anchors.verticalCenter: parent.verticalCenter
                color: isCurrent || __hoverHandler.hovered ? DelTheme.DelBreadcrumb.colorIconLast :
                                                             DelTheme.DelBreadcrumb.colorIcon;
                iconSize: model.iconSize
                iconSource: model.loading ? DelIcon.LoadingOutlined : model.iconSource
                verticalAlignment: Text.AlignVCenter

                NumberAnimation on rotation {
                    running: model.loading
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    duration: 1000
                }

                Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: DelTheme.Primary.durationFast } }
            }

            DelCopyableText {
                id: __text
                anchors.verticalCenter: parent.verticalCenter
                text: model.title
                font: control.titleFont
                enabled: isCurrent
                color: __icon.color

                Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: DelTheme.Primary.durationFast } }
            }

            Loader {
                anchors.verticalCenter: parent.verticalCenter
                active: __itemDelegate.menuItem.length > 0
                sourceComponent: DelIconText {
                    color: isCurrent || __hoverHandler.hovered ? DelTheme.DelBreadcrumb.colorIconLast :
                                                                 DelTheme.DelBreadcrumb.colorIcon;
                    iconSource: DelIcon.DownOutlined
                    verticalAlignment: Text.AlignVCenter

                    Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: DelTheme.Primary.durationFast } }
                }
            }
        }

        HoverHandler {
            id: __hoverHandler
            cursorShape: !isCurrent ? Qt.PointingHandCursor : Qt.ArrowCursor
            onHoveredChanged: {
                if (hovered) __private.hover(index);
            }
        }

        TapHandler {
            id: __tapHandler
            enabled: !isCurrent
            onTapped: control.click(index, model);
        }

        Loader {
            active: __itemDelegate.menuItem.length > 0
            sourceComponent: DelContextMenu {
                id: __menu
                parent: __itemDelegate
                x: (parent.width - implicitWidth) * 0.5
                y: parent.height
                tooltipVisible: true
                initModel: __itemDelegate.menuItem
                defaultMenuWidth: __itemDelegate.menu.width ?? control.defaultMenuWidth
                closePolicy: DelPopup.NoAutoClose | DelPopup.CloseOnPressOutsideParent | DelPopup.CloseOnEscape
                onHoveredChanged: if (hovered) open();
                onClickMenu: (deep, menuKey, menuData) => control.clickMenu(deep, menuKey, menuData);
                property bool hovered: __hoverHandler.hovered

                Connections {
                    target: __private
                    function onHover(index) {
                        if (__itemDelegate.__index !== index && __menu.opened) {
                            __menu.close();
                        }
                    }
                }
            }
        }
    }
    property Component separatorDelegate: DelText {
        text: model.separator ?? ''
        color: DelTheme.DelBreadcrumb.colorIcon
    }

    onInitModelChanged: reset();

    function get(index) {
        return __listModel.get(index);
    }

    function set(index, object) {
        __listModel.set(index, __private.initObject(object));
    }

    function setProperty(index, propertyName, value) {
        __listModel.setProperty(index, propertyName, value);
    }

    function move(from, to, count = 1) {
        __listModel.move(from, to, count);
    }

    function insert(index, object) {
        __listModel.insert(index, __private.initObject(object));
    }

    function append(object) {
        __listModel.append(__private.initObject(object));
    }

    function remove(index, count = 1) {
        __listModel.remove(index, count);
    }

    function clear() {
        __listModel.clear();
    }

    function reset() {
        clear();
        for (const object of initModel) {
            append(object);
        }
    }

    function getPath() {
        let path = '';
        for (let i = 0; i < __listModel.count; i++) {
            path += __listModel.get(i).title + ((i + 1 != count) ? __listModel.get(i).separator : '');
        }
        return path;
    }

    QtObject {
        id: __private
        signal hover(index: int)
        function initObject(object) {
            if (!object.hasOwnProperty("title")) object.title = '';

            if (!object.hasOwnProperty("iconSource")) object.iconSource = 0;
            if (!object.hasOwnProperty("iconUrl")) object.iconUrl = '';
            if (!object.hasOwnProperty("iconSize")) object.iconSize = control.defaultIconSize;
            if (!object.hasOwnProperty("loading")) object.loading = false;

            if (!object.hasOwnProperty("separator")) object.separator = control.separator;
            if (!object.hasOwnProperty("itemDelegate")) object.itemDelegate = control.itemDelegate;
            if (!object.hasOwnProperty("separatorDelegate")) object.separatorDelegate = control.separatorDelegate;

            if (!object.hasOwnProperty("menu")) object.menu = {};

            return object;
        }
    }

    ListView{
        id: __listView
        width: parent.width
        height: parent.height
        orientation: ListView.Horizontal
        model: ListModel { id: __listModel }
        clip: true
        spacing: control.spacing
        boundsBehavior: ListView.StopAtBounds
        add: Transition {
            NumberAnimation {
                properties: 'opacity'
                from: 0
                to: 1
                duration: control.animationEnabled ? DelTheme.Primary.durationFast : 0
            }
        }
        remove: Transition {
            NumberAnimation {
                properties: 'opacity'
                from: 1
                to: 0
                duration: control.animationEnabled ? DelTheme.Primary.durationFast : 0
            }
        }
        delegate: Item {
            id: __rootItem
            width: __row.implicitWidth
            height: __listView.height

            required property int index
            required property var model
            property bool isCurrent: (index + 1) === __listModel.count

            Row {
                id: __row
                height: parent.height
                spacing: control.spacing

                Loader {
                    anchors.verticalCenter: parent.verticalCenter
                    sourceComponent: model.itemDelegate
                    property alias index: __rootItem.index
                    property alias model: __rootItem.model
                    property alias isCurrent: __rootItem.isCurrent
                }

                Loader {
                    anchors.verticalCenter: parent.verticalCenter
                    active: index + 1 !== __listModel.count
                    sourceComponent: model.separatorDelegate
                    property alias index: __rootItem.index
                    property alias model: __rootItem.model
                    property alias isCurrent: __rootItem.isCurrent
                }
            }
        }
    }
}

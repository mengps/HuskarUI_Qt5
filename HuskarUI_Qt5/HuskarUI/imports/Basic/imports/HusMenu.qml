import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Window 2.15
import HuskarUI.Basic 1.0

Item {
    id: control

    implicitWidth: compactMode ? compactWidth : defaultMenuWidth
    implicitHeight: __listView.contentHeight + __listView.anchors.topMargin + __listView.anchors.bottomMargin
    clip: true

    signal clickMenu(deep: int, menuKey: string, menuData: var)

    property bool animationEnabled: HusTheme.animationEnabled
    property string contentDescription: ''
    property bool showEdge: false
    property bool tooltipVisible: false
    property bool compactMode: false
    property int compactWidth: 50
    property bool popupMode: false
    property int popupWidth: 200
    property int popupOffset: 4
    property int popupMaxHeight: control.height
    property int defaultMenuIconSize: HusTheme.HusMenu.fontSize
    property int defaultMenuIconSpacing: 8
    property int defaultMenuWidth: 300
    property int defaultMenuHeight: 40
    property int defaultMenuSpacing: 4
    property var defaultSelectedKey: []
    property var initModel: []

    property Component menuIconDelegate: HusIconText {
        color: menuButton.colorText
        iconSize: menuButton.iconSize
        iconSource: menuButton.iconSource
        verticalAlignment: Text.AlignVCenter

        Behavior on x {
            enabled: control.animationEnabled
            NumberAnimation { easing.type: Easing.OutCubic; duration: HusTheme.Primary.durationMid }
        }
        Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationFast } }
    }
    property Component menuLabelDelegate: HusText {
        text: menuButton.text
        font: menuButton.font
        color: menuButton.colorText
        elide: Text.ElideRight

        Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationFast } }
    }
    property Component menuBackgroundDelegate: Rectangle {
        radius: menuButton.radiusBg
        color: menuButton.colorBg
        border.color: menuButton.colorBorder
        border.width: 1

        Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationMid } }
        Behavior on border.color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationMid } }
    }
    property Component menuContentDelegate: Item {
        id: __menuContentItem
        property var __menuButton: menuButton

        Loader {
            id: __iconLoader
            x: menuButton.iconStart
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: menuButton.iconDelegate
            property var model: __menuButton.model
            property alias menuButton: __menuContentItem.__menuButton
        }

        Loader {
            id: __labelLoader
            anchors.left: __iconLoader.right
            anchors.leftMargin: menuButton.iconSpacing
            anchors.right: menuButton.expandedVisible ? __expandedIcon.left : parent.right
            anchors.rightMargin: menuButton.iconSpacing
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: menuButton.labelDelegate
            property var model: __menuButton.model
            property alias menuButton: __menuContentItem.__menuButton
        }

        HusIconText {
            id: __expandedIcon
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: menuButton.expandedVisible
            iconSource: (control.compactMode || control.popupMode) ? HusIcon.RightOutlined : HusIcon.DownOutlined
            colorIcon: menuButton.colorText
            transform: Rotation {
                origin {
                    x: __expandedIcon.width * 0.5
                    y: __expandedIcon.height * 0.5
                }
                axis {
                    x: 1
                    y: 0
                    z: 0
                }
                angle: (control.compactMode || control.popupMode) ? 0 : (menuButton.expanded ? 180 : 0)
                Behavior on angle { enabled: control.animationEnabled; NumberAnimation { duration: HusTheme.Primary.durationMid } }
            }
            Behavior on color { enabled: control.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationFast } }
        }
    }

    onInitModelChanged: {
        __listView.model = __private.model = initModel;
    }

    function gotoMenu(key) {
        __private.gotoMenuKey = key;
        __private.gotoMenu(key);
    }

    function get(index) {
        if (index >= 0 && index < __listView.model.length) {
            return __listView.model[index];
        }
        return undefined;
    }

    function set(index, object) {
        if (index >= 0 && index < __listView.model.length) {
            __private.model[index] = object;
            __listView.model = __private.model;
        }
    }

    function setProperty(index, propertyName, value) {
        if (index >= 0 && index < __listView.model.length) {
            __private.model[index][propertyName] = value;
            __listView.model = __private.model;
        }
    }

    function move(from, to, count = 1) {
        if (from >= 0 && from < __listView.model.length && to >= 0 && to < __listView.model.length) {
            const objects = __listView.model.splice(from, count);
            __private.model.splice(to, 0, ...objects);
            __listView.model = __private.model;
        }
    }

    function insert(index, object) {
        __private.model.splice(index, 0, object);
        __listView.model = __private.model;
    }

    function append(object) {
        __private.model.push(object);
        __listView.model = __private.model;
    }

    function remove(index, count = 1) {
        if (index >= 0 && index < __listView.model.length) {
            __private.model.splice(index, count);
            __listView.model = __private.model;
        }
    }

    function clear() {
        __private.gotoMenuKey = '';
        __listView.model = [];
    }

    component MenuButton: HusButton {
        id: __menuButtonImpl

        property int iconSource: 0
        property int iconSize: HusTheme.HusMenu.fontSize
        property int iconSpacing: 5
        property int iconStart: 0
        property bool expanded: false
        property bool expandedVisible: false
        property bool isCurrent: false
        property bool isGroup: false
        property var model: undefined
        property var iconDelegate: null
        property var labelDelegate: null
        property var contentDelegate: null
        property var backgroundDelegate: null

        onClicked: {
            if (expandedVisible)
                expanded = !expanded;
        }
        hoverCursorShape: (isGroup && !control.compactMode) ? Qt.ArrowCursor : Qt.PointingHandCursor
        effectEnabled: false
        colorBorder: 'transparent'
        colorText: {
            if (enabled) {
                if (isGroup) {
                    return (isCurrent && control.compactMode) ? HusTheme.HusMenu.colorTextActive : HusTheme.HusMenu.colorTextDisabled;
                } else {
                    return isCurrent ? HusTheme.HusMenu.colorTextActive : HusTheme.HusMenu.colorText;
                }
            } else {
                return HusTheme.HusMenu.colorTextDisabled;
            }
        }
        colorBg: {
            if (enabled) {
                if (isGroup)
                    return (isCurrent && control.compactMode) ? HusTheme.HusMenu.colorBgActive : HusTheme.HusMenu.colorBgDisabled;
                else if (isCurrent)
                    return HusTheme.HusMenu.colorBgActive;
                else if (hovered) {
                    return HusTheme.HusMenu.colorBgHover;
                } else {
                    return HusTheme.HusMenu.colorBg;
                }
            } else {
                return HusTheme.HusMenu.colorBgDisabled;
            }
        }
        contentItem: Loader {
            sourceComponent: __menuButtonImpl.contentDelegate
            property alias model: __menuButtonImpl.model
            property alias menuButton: __menuButtonImpl
        }
        background: Loader {
            sourceComponent: __menuButtonImpl.backgroundDelegate
            property alias model: __menuButtonImpl.model
            property alias menuButton: __menuButtonImpl
        }
    }

    Behavior on width {
        enabled: control.animationEnabled
        NumberAnimation {
            easing.type: Easing.OutCubic
            duration: HusTheme.Primary.durationMid
        }
    }

    Behavior on implicitWidth {
        enabled: control.animationEnabled
        NumberAnimation {
            easing.type: Easing.OutCubic
            duration: HusTheme.Primary.durationMid
        }
    }

    Component {
        id: __menuDelegate

        Item {
            id: __rootItem
            width: ListView.view.width
            height: {
                switch (menuType) {
                case 'item':
                case 'group':
                    return __layout.height;
                case 'divider':
                    return __dividerLoader.height;
                default:
                    return __layout.height;
                }
            }
            clip: true
            Component.onCompleted: {
                if (menuType == 'item' || menuType == 'group') {
                    layerPopup = __private.createPopupList(view.menuDeep);
                    let list = []
                    for (let i = 0; i < menuChildren.length; i++) {
                        list.push(menuChildren[i]);
                    }
                    __childrenListView.model = list;
                    if (control.defaultSelectedKey.length != 0) {
                        if (control.defaultSelectedKey.indexOf(menuKey) != -1) {
                            __rootItem.expandParent();
                            __menuButton.clicked();
                        }
                    }
                }
                if (__rootItem.menuKey !== '' && __rootItem.menuKey === __private.gotoMenuKey) {
                    __rootItem.expandParent();
                    __menuButton.clicked();
                }
            }

            required property var modelData
            property alias model: __rootItem.modelData
            property var view: ListView.view
            property string menuKey: model.key || ''
            property string menuType: model.type || 'item'
            property bool menuEnabled: model.enabled === undefined ? true : model.enabled
            property string menuLabel: model.label || ''
            property int menuHeight: model.height || defaultMenuHeight
            property int menuIconSize: model.iconSize || defaultMenuIconSize
            property int menuIconSource: model.iconSource || 0
            property int menuIconSpacing: model.iconSpacing || defaultMenuIconSpacing
            property var menuChildren: model.menuChildren || []
            property int menuChildrenLength: menuChildren ? menuChildren.length : 0
            property var menuIconDelegate: model.iconDelegate ?? control.menuIconDelegate
            property var menuLabelDelegate: model.labelDelegate ?? control.menuLabelDelegate
            property var menuContentDelegate: model.contentDelegate ?? control.menuContentDelegate
            property var menuBackgroundDelegate: model.backgroundDelegate ?? control.menuBackgroundDelegate

            property var parentMenu: view.menuDeep === 0 ? null : view.parentMenu
            property bool isCurrent: __private.selectedItem === __rootItem || isCurrentParent
            property bool isCurrentParent: false
            property var layerPopup: null

            function expandMenu() {
                if (__menuButton.expandedVisible)
                    __menuButton.expanded = true;
            }

            /*! 查找当前菜单的根菜单 */
            function findRootMenu() {
                let parent = parentMenu;
                while (parent !== null) {
                    if (parent.parentMenu === null)
                        return parent;
                    parent = parent.parentMenu;
                }
                /*! 根菜单返回自身 */
                return __rootItem;
            }
            /*! 展开当前菜单的所有父菜单 */
            function expandParent() {
                let parent = parentMenu;
                while (parent !== null) {
                    if (parent.parentMenu === null) {
                        parent.expandMenu();
                        return;
                    }
                    parent.expandMenu();
                    parent = parent.parentMenu;
                }
            }
            /*! 清除当前菜单的所有子菜单 */
            function clearIsCurrentParent() {
                isCurrentParent = false;
                for (let i = 0; i < __childrenListView.count; i++) {
                    let item = __childrenListView.itemAtIndex(i);
                    if (item)
                        item.clearIsCurrentParent();
                }
            }
            /*! 选中当前菜单的所有父菜单 */
            function selectedCurrentParentMenu() {
                for (let i = 0; i < __listView.count; i++) {
                    let item = __listView.itemAtIndex(i);
                    if (item)
                        item.clearIsCurrentParent();
                }
                let parent = parentMenu;
                while (parent !== null) {
                    parent.isCurrentParent = true;
                    if (parent.parentMenu === null)
                        return;
                    parent = parent.parentMenu;
                }
            }

            Connections {
                target: __private
                function onGotoMenu(key) {
                    if (__rootItem.menuKey !== '' && __rootItem.menuKey === key) {
                        __rootItem.expandParent();
                        __menuButton.clicked();
                    }
                }
            }

            Loader {
                id: __dividerLoader
                height: 5
                width: parent.width
                active: __rootItem.menuType == 'divider'
                sourceComponent: HusDivider { }
            }

            Rectangle {
                id: __layout
                width: parent.width
                anchors.top: parent.top
                height: __menuButton.height + ((control.compactMode || control.popupMode) ? 0 : __childrenListView.height)
                color: (view.menuDeep === 0 || control.compactMode || control.popupMode) ? 'transparent' : HusTheme.HusMenu.colorChildBg
                visible: menuType == 'item' || menuType == 'group'

                MenuButton {
                    id: __menuButton
                    width: parent.width
                    height: __rootItem.menuHeight + control.defaultMenuSpacing
                    topInset: control.defaultMenuSpacing * 0.5
                    leftPadding: 15 + (control.compactMode || control.popupMode ? 0 : iconSize * __rootItem.view.menuDeep)
                    bottomInset: control.defaultMenuSpacing * 0.5
                    enabled: __rootItem.menuEnabled
                    text: (control.compactMode && __rootItem.view.menuDeep === 0) ? '' : __rootItem.menuLabel
                    checkable: true
                    iconSize: __rootItem.menuIconSize
                    iconSource: __rootItem.menuIconSource
                    iconSpacing: __rootItem.menuIconSpacing
                    iconStart: (control.compactMode && __rootItem.view.menuDeep === 0) ? (width - iconSize - leftPadding - rightPadding) * 0.5 : 0
                    expandedVisible: {
                        if (__rootItem.menuType == 'group' ||
                                (control.compactMode && __rootItem.view.menuDeep === 0))
                            return false;
                        else
                            return __rootItem.menuChildrenLength > 0
                    }
                    isCurrent: __rootItem.isCurrent
                    isGroup: __rootItem.menuType == 'group'
                    model: __rootItem.model
                    iconDelegate: __rootItem.menuIconDelegate
                    labelDelegate: __rootItem.menuLabelDelegate
                    contentDelegate: __rootItem.menuContentDelegate
                    backgroundDelegate: __rootItem.menuBackgroundDelegate
                    onClicked: {
                        if (__rootItem.menuChildrenLength == 0) {
                            control.clickMenu(__rootItem.view.menuDeep, __rootItem.menuKey, model);
                            __private.selectedItem = __rootItem;
                            __rootItem.selectedCurrentParentMenu();
                            if (control.compactMode || control.popupMode)
                                __rootItem.layerPopup.closeWithParent();
                        } else {
                            if (control.compactMode || control.popupMode) {
                                const h = __rootItem.layerPopup.topPadding +
                                        __rootItem.layerPopup.bottomPadding +
                                        __childrenListView.realHeight + 6;
                                const pos = mapToItem(null, 0, 0);
                                const pos2 = mapToItem(control, 0, 0);
                                if ((pos.y + h) > __private.window.height) {
                                    __rootItem.layerPopup.y = Math.max(0, pos2.y - ((pos.y + h) - __private.window.height));
                                } else {
                                    __rootItem.layerPopup.y = pos2.y;
                                }
                                __rootItem.layerPopup.current = __childrenListView;
                                __rootItem.layerPopup.open();
                            }
                        }
                    }

                    HusToolTip {
                        position: control.compactMode || control.popupMode ? HusToolTip.Position_Right : HusToolTip.Position_Bottom
                        text: __rootItem.menuLabel
                        visible: control.tooltipVisible ? parent.hovered : false
                        delay: 500
                    }
                }

                ListView {
                    id: __childrenListView
                    visible: __rootItem.menuEnabled
                    parent: {
                        if (__rootItem.layerPopup && __rootItem.layerPopup.current === __childrenListView)
                            return __rootItem.layerPopup.contentItem;
                        else
                            return __layout;
                    }
                    height: {
                        if (__rootItem.menuType == 'group' || __menuButton.expanded)
                            return realHeight;
                        else if (parent != __layout)
                            return parent.height;
                        else
                            return 0;
                    }
                    anchors.top: parent ? (parent == __layout ? __menuButton.bottom : parent.top) : undefined
                    anchors.left: parent ? parent.left : undefined
                    anchors.right: parent ? parent.right : undefined
                    boundsBehavior: Flickable.StopAtBounds
                    interactive: __childrenListView.visible
                    model: []
                    delegate: __menuDelegate
                    onContentHeightChanged: cacheBuffer = contentHeight;
                    T.ScrollBar.vertical: HusScrollBar {
                        id: childrenScrollBar
                        visible: (control.compactMode || control.popupMode) && childrenScrollBar.size !== 1
                    }
                    clip: true
                    /* 子 ListView 从父 ListView 的深度累加可实现自动计算 */
                    property int menuDeep: __rootItem.view.menuDeep + 1
                    property var parentMenu: __rootItem
                    property int realHeight: contentHeight

                    Behavior on height {
                        enabled: control.animationEnabled
                        NumberAnimation { duration: HusTheme.Primary.durationFast }
                    }

                    Connections {
                        target: control
                        function onCompactModeChanged() {
                            if (__rootItem.layerPopup) {
                                __rootItem.layerPopup.current = null;
                                __rootItem.layerPopup.close();
                            }
                        }
                        function onPopupModeChanged() {
                            if (__rootItem.layerPopup) {
                                __rootItem.layerPopup.current = null;
                                __rootItem.layerPopup.close();
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        id: __private
        signal gotoMenu(key: string)
        property string gotoMenuKey: ''
        property var model: []
        property var window: Window.window
        property var selectedItem: null
        property var popupList: []
        function createPopupList(deep) {
            /*! 为每一层创建一个弹窗 */
            if (popupList[deep] === undefined) {
                let parentPopup = deep > 0 ? popupList[deep - 1] : null;
                popupList[deep] = __popupComponent.createObject(control, { parentPopup: parentPopup });
            }
            return popupList[deep];
        }
    }

    Loader {
        width: 1
        height: parent.height
        anchors.right: parent.right
        active: control.showEdge
        sourceComponent: Rectangle {
            color: HusTheme.HusMenu.colorEdge
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: (wheel) => wheel.accepted = true;
    }

    Component {
        id: __popupComponent

        HusPopup {
            width: control.popupWidth
            height: current ? Math.min(control.popupMaxHeight, current.realHeight + topPadding + bottomPadding) : 0
            padding: 5
            onAboutToShow: {
                let toX = control.width + control.popupOffset;
                if (parentPopup) {
                    toX += parentPopup.width + control.popupOffset;
                }
                const pos = mapToItem(null, toX, 0);
                if (pos.x + width > __private.window.width) {
                    if (parentPopup) {
                        x = parentPopup.x - parentPopup.width - control.popupOffset;
                    } else {
                        x = -width - control.popupOffset;
                    }
                } else {
                    x = toX;
                }
            }
            property var current: null
            property var parentPopup: null
            function closeWithParent() {
                close();
                let p = parentPopup;
                while (p) {
                    p.close();
                    p = p.parentPopup;
                }
            }
        }
    }

    ListView {
        id: __listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 5
        boundsBehavior: Flickable.StopAtBounds
        delegate: __menuDelegate
        onContentHeightChanged: cacheBuffer = contentHeight;
        T.ScrollBar.vertical: HusScrollBar {
            anchors.rightMargin: -8
        }
        property int menuDeep: 0
    }

    Accessible.role: Accessible.Tree
    Accessible.description: control.contentDescription
}

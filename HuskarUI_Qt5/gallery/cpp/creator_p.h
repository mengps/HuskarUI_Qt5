#ifndef CREATOR_P_H
#define CREATOR_P_H

static auto g_cmake_src_subdirectory = R"(
cmake_minimum_required(VERSION 3.16)

project(%1_Solution)

option(BUILD_HUSKARUI_STATIC_LIBRARY "Build HuskarUI as a static library." %2)
option(BUILD_HUSKARUI_ON_DESKTOP_PLATFORM "Build HuskarUI on desktop platform (mobile platform set OFF)." ON)

if (WIN32 OR MACOS OR LINUX)
    set(BUILD_HUSKARUI_ON_DESKTOP_PLATFORM ON)
else()
    set(BUILD_HUSKARUI_ON_DESKTOP_PLATFORM OFF)
endif()

if(BUILD_HUSKARUI_ON_DESKTOP_PLATFORM)
    #Build QWindowKit
    set(QWINDOWKIT_BUILD_STATIC ON)
    set(QWINDOWKIT_BUILD_WIDGETS OFF)
    set(QWINDOWKIT_BUILD_QUICK ON)
    set(QWINDOWKIT_INSTALL OFF)
    add_subdirectory(3rdparty/qwindowkit)
endif()

#Build HuskarUI
add_subdirectory(3rdparty/HuskarUI)

#Your project
add_subdirectory(src)
)";

static auto g_cmake_lib_subdirectory = R"(
cmake_minimum_required(VERSION 3.16)

project(%1_Solution)

option(BUILD_HUSKARUI_STATIC_LIBRARY "HuskarUI is static library." %2)

#Your project
add_subdirectory(src)
)";

static auto g_cmake_project =R"(
cmake_minimum_required(VERSION 3.16)

project(%1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

find_package(Qt5 COMPONENTS Quick REQUIRED)

set(SOURCES main.cpp)
qt5_add_resources(SOURCES qml.qrc)
add_executable(${PROJECT_NAME} ${SOURCES})

target_compile_definitions(${PROJECT_NAME} PRIVATE
    $<$<BOOL:${BUILD_HUSKARUI_STATIC_LIBRARY}>:BUILD_HUSKARUI_STATIC_LIBRARY>
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)
)";

static auto g_cmake_qml_import = R"(
set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/3rdparty/HuskarUI/imports/Basic/imports CACHE STRING "" FORCE)
target_compile_definitions(${PROJECT_NAME} PRIVATE
    HUSKARUI_IMPORT_PATH="${QML_IMPORT_PATH}"
)
)";

static auto g_cmake_nocontain_link = R"(
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
)
)";

static auto g_cmake_only_link_huskarui = R"(
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
    HuskarUIBasic
    $<$<BOOL:${BUILD_HUSKARUI_STATIC_LIBRARY}>:HuskarUIBasicPlugin>
)
)";

static auto g_cmake_link_huskarui = R"(
target_include_directories(${PROJECT_NAME} PRIVATE %1)
target_link_directories(${PROJECT_NAME} PRIVATE %2)
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
    HuskarUIBasic
    $<$<BOOL:${BUILD_HUSKARUI_STATIC_LIBRARY}>:HuskarUIBasicPlugin>
)
)";

static auto g_cmake_install = R"(
include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
)";

static auto g_cmake_deploy = R"(
## Deploy Script
if(CMAKE_BUILD_TYPE MATCHES "Release")
    if(APPLE)
        find_program(QT_DEPLOY_QT NAMES macdeployqt)
        set(QT_DEPLOY_ARGS
            ${CMAKE_SOURCE_DIR}/package/${PROJECT_NAME}.app
            --qmldir=${CMAKE_CURRENT_LIST_DIR}/qml
            --no-virtualkeyboard
        )
        add_custom_target(Script-DeployRelease
                COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_SOURCE_DIR}/package
                COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} ${CMAKE_SOURCE_DIR}/package
                COMMAND ${QT_DEPLOY_QT} ${QT_DEPLOY_ARGS}
                COMMENT "MacOs Deploying Qt Dependencies After Build........."
                SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )
        add_dependencies(Script-DeployRelease ${PROJECT_NAME})
    endif()
    if(WIN32)
        find_program(QT_DEPLOY_QT NAMES windeployqt)
        set(QT_DEPLOY_ARGS
            --qmldir=${CMAKE_CURRENT_LIST_DIR}/qml
            --plugindir=${CMAKE_SOURCE_DIR}/package/plugins
            --no-virtualkeyboard
            --compiler-runtime
            ${CMAKE_SOURCE_DIR}/package/${PROJECT_NAME}.exe
        )
        add_custom_target(Script-DeployRelease
                COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_SOURCE_DIR}/package
                COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} ${CMAKE_SOURCE_DIR}/package
                COMMAND ${CMAKE_COMMAND} -E rm -f "${CMAKE_SOURCE_DIR}/package/${PROJECT_NAME}.qmltypes"
                COMMAND ${CMAKE_COMMAND} -E rm -f "${CMAKE_SOURCE_DIR}/package/${PROJECT_NAME}_qml_module_dir_map.qrc"
                COMMAND ${CMAKE_COMMAND} -E rm -f "${CMAKE_SOURCE_DIR}/package/qmldir"
                COMMAND ${QT_DEPLOY_QT} ${QT_DEPLOY_ARGS}
                COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/package/HuskarUI/Basic/HuskarUIBasic.dll ${CMAKE_SOURCE_DIR}/package
                COMMENT "Windows Deploying Qt Dependencies After Build........."
                SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )
        add_dependencies(Script-DeployRelease ${PROJECT_NAME})
    endif()
endif()
)";


static auto g_nocontain_main_cpp_file = R"(
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("%1", "Main");

    return app.exec();
}
)";

static auto g_nocontain_main_qml_file = R"(
import QtQuick 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr('%1')
}
)";

static auto g_main_cpp_file = R"(
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

#ifdef BUILD_HUSKARUI_STATIC_LIBRARY
#include <QtQml/qqmlextensionplugin.h>
Q_IMPORT_QML_PLUGIN(HuskarUI_BasicPlugin)
#endif

#include <husapp.h>

int main(int argc, char *argv[])
{
    QQuickWindow::setDefaultAlphaBuffer(true);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    HusApp::initialize(&engine);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("%1", "Main");

    return app.exec();
}
)";

static auto g_main_add_import_cpp_file = R"(
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

#ifdef BUILD_HUSKARUI_STATIC_LIBRARY
#include <QtQml/qqmlextensionplugin.h>
Q_IMPORT_QML_PLUGIN(HuskarUI_BasicPlugin)
#endif

#include <husapp.h>

int main(int argc, char *argv[])
{
    QQuickWindow::setDefaultAlphaBuffer(true);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    HusApp::initialize(&engine);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.addImportPath(HUSKARUI_IMPORT_PATH);
    engine.loadFromModule("%1", "Main");

    return app.exec();
}
)";

static auto g_main_qml_file = R"(
import QtQuick 2.15
import HuskarUI.Basic 1.0

HusWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr('%1')
    captionBar.winIconVisible: false
    Component.onCompleted: {
        if (Qt.platform.os === 'windows') {
            if (setSpecialEffect(HusWindow.Win_MicaAlt)) return;
            if (setSpecialEffect(HusWindow.Win_Mica)) return;
            if (setSpecialEffect(HusWindow.Win_AcrylicMaterial)) return;
            if (setSpecialEffect(HusWindow.Win_DwmBlur)) return;
        } else if (Qt.platform.os === 'osx') {
            if (setSpecialEffect(HusWindow.Mac_BlurEffect)) return;
        }
    }
}
)";

#endif // CREATOR_P_H

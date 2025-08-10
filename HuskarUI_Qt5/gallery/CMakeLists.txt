cmake_minimum_required(VERSION 3.16)

set(HUSKARUI_VERSION 0.4.2.0)

project(Gallery VERSION ${HUSKARUI_VERSION} LANGUAGES CXX)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

find_package(Qt5 COMPONENTS Quick REQUIRED)

#Add HuskarUIHelper
include(${CMAKE_CURRENT_LIST_DIR}/../.cmake/HuskarUIHelper.cmake)
#Add QmlPluginHelper
include(${CMAKE_CURRENT_LIST_DIR}/../.cmake/QmlPluginHelper.cmake)

set(GALLERY_RC_FILE "")
if (WIN32)
    set(GALLERY_RC_FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}_Resource.rc)
    hus_add_win_rc(${PROJECT_NAME}
        COMMENTS "HuskarUI Gallery"
        NAME "${PROJECT_NAME}.exe"
        COMPANY "HuskarUI"
        DESCRIPTION ""
        VERSION "${PROJECT_VERSION}"
        COPYRIGHT "Copyright (C) 2025 mengps. All rights reserved."
        ICONS ../resources/huskarui_icon.ico
        OUTPUT_FILE "${GALLERY_RC_FILE}"
    )
endif()

hus_get_dir_sources(FILTER "*.h" "*.cpp" OUTPUT CPP_SOURCES)

qt5_add_resources(QRC_SOURCES qml.qrc resource.qrc shaders.qrc)

add_executable(${PROJECT_NAME}
    ${CPP_SOURCES}
    ${QRC_SOURCES}
    ${GALLERY_RC_FILE}
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER huskarui.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE #VSCode 打印需要屏蔽此属性
)

target_include_directories(${PROJECT_NAME} PRIVATE
    cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE 
    Qt::Quick
    HuskarUIBasic
    $<$<BOOL:${BUILD_HUSKARUI_STATIC_LIBRARY}>:HuskarUIBasicPlugin>
)

if (BUILD_HUSKARUI_STATIC_LIBRARY)
    target_compile_definitions(${PROJECT_NAME} PRIVATE BUILD_HUSKARUI_STATIC_LIBRARY)
endif()

# Deploy Script
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
                COMMENT "Windows Deploying Qt Dependencies After Build........."
                COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/package/HuskarUI/Basic/HuskarUIBasic.dll ${CMAKE_SOURCE_DIR}/package
                SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )
        add_dependencies(Script-DeployRelease ${PROJECT_NAME})
    endif()
endif()

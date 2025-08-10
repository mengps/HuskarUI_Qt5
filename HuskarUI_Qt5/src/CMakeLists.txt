cmake_minimum_required(VERSION 3.16)

set(HUSKARUI_VERSION 0.4.2.0)

message(STATUS "Configuring HuskarUI Version: ${HUSKARUI_VERSION}")

project(HuskarUIBasic VERSION ${HUSKARUI_VERSION} LANGUAGES CXX)

#Add HuskarUIHelper
include(${CMAKE_CURRENT_LIST_DIR}/../.cmake/HuskarUIHelper.cmake)
#Add QmlPluginHelper
include(${CMAKE_CURRENT_LIST_DIR}/../.cmake/QmlPluginHelper.cmake)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

find_package(Qt5 COMPONENTS Quick REQUIRED)

#Set plugin output dir
set(HUSKARUI_HEADER_OUTPUT_DIRECTORY "" CACHE PATH "HuskarUI headeroutput dir.")
set(HUSKARUI_LIBRARY_OUTPUT_DIRECTORY "" CACHE PATH "HuskarUI library output dir.")
set(HUSKARUI_PLUGIN_OUTPUT_DIRECTORY "" CACHE PATH "HuskarUI plugin output dir.")

if(NOT HUSKARUI_HEADER_OUTPUT_DIRECTORY)
    set(HUSKARUI_HEADER_OUTPUT_DIRECTORY ${Qt5_DIR}/../../../include/HuskarUI)
endif()

if(NOT HUSKARUI_PLUGIN_OUTPUT_DIRECTORY)
    set(HUSKARUI_LIBRARY_OUTPUT_DIRECTORY ${Qt5_DIR}/../../../)
    set(HUSKARUI_PLUGIN_OUTPUT_DIRECTORY ${Qt5_DIR}/../../../qml/HuskarUI/Basic)
    if(BUILD_HUSKARUI_STATIC_LIBRARY)
        set(HUSKARUI_PLUGIN_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/HuskarUI/Basic)
    endif()
endif()

set(LIBRARY_TYPE "")
if(BUILD_HUSKARUI_STATIC_LIBRARY)
    set(LIBRARY_TYPE "STATIC")
else()
    set(LIBRARY_TYPE "SHARED")
endif()

set(HUSKARUI_RC_FILE "")
if(WIN32)
    set(HUSKARUI_RC_FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}_Resource.rc)
    set(RC_NAME "")
    if(BUILD_HUSKARUI_STATIC_LIBRARY)
        set(RC_NAME "${PROJECT_NAME}.lib")
    else()
        set(RC_NAME "${PROJECT_NAME}.dll")
    endif()
    hus_add_win_rc(${PROJECT_NAME}
        COMMENTS "Modern UI-Kit for Qml { Design reference Ant-d }"
        NAME ${RC_NAME}
        COMPANY "HuskarUI"
        DESCRIPTION "https://github.com/mengps/HuskarUI"
        VERSION "${PROJECT_VERSION}"
        COPYRIGHT "Copyright (C) 2025 mengps. All rights reserved."
        OUTPUT_FILE "${HUSKARUI_RC_FILE}"
    )
endif()

hus_get_dir_sources(FILTER "qml/*.qml" OUTPUT QML_SOURCES)
hus_get_dir_sources(FILTER "cpp/*.h" "cpp/*.cpp" OUTPUT CPP_SOURCES)

qt5_add_resources(QRC_SOURCES qml.qrc theme.qrc resource.qrc shaders.qrc)

add_qmlplugin(${PROJECT_NAME}
    URI "HuskarUI.Basic"
    VERSION 1.0
    SOURCES ${CPP_SOURCES} ${QRC_SOURCES}
    QMLFILES ${QML_SOURCES}
    QMLDIR imports/HuskarUI
    BINARY_DIR ${HUSKARUI_PLUGIN_OUTPUT_DIRECTORY}
    LIBTYPE ${LIBRARY_TYPE}
)

if(MINGW)
    set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
    target_compile_options(${PROJECT_NAME} PRIVATE -Wa,-mbig-obj)
elseif(MSVC)
    set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
    target_compile_options(${PROJECT_NAME} PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/utf-8;/Zi>)
endif()

target_compile_definitions(${PROJECT_NAME} PRIVATE
    BUILD_HUSKARUI_LIB
    HUSKARUI_LIBRARY_VERSION="${HUSKARUI_VERSION}"
    $<$<BOOL:${BUILD_HUSKARUI_STATIC_LIBRARY}>:BUILD_HUSKARUI_STATIC_LIBRARY>
    $<$<BOOL:${BUILD_HUSKARUI_ON_DESKTOP_PLATFORM}>:BUILD_HUSKARUI_ON_DESKTOP_PLATFORM>
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    Qt::QuickPrivate
    QWKCore
    QWKQuick
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/theme
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/controls
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/utils
)

#Gen HuskarUI/include
if (HUSKARUI_HEADER_OUTPUT_DIRECTORY)
    file(COPY cpp/husglobal.h cpp/husapp.h cpp/husdefinitions.h cpp/controls cpp/theme cpp/utils
         DESTINATION ${HUSKARUI_HEADER_OUTPUT_DIRECTORY}
         FILES_MATCHING PATTERN "*.h"
         PATTERN "*_p.h" EXCLUDE)
endif()

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/bin
    ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/lib
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/lib
)

install(
    FILES cpp/husglobal.h cpp/husapp.h cpp/husdefinitions.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/include
)

install(
    DIRECTORY cpp/controls cpp/theme cpp/utils
    DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/include
    FILES_MATCHING PATTERN "*.h"
    PATTERN "*_p.h" EXCLUDE
)

install(
    DIRECTORY ${HUSKARUI_PLUGIN_OUTPUT_DIRECTORY} DESTINATION ${CMAKE_INSTALL_PREFIX}/HuskarUI/imports
)

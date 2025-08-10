#include "huskarui_plugin.h"

#include <husapi.h>
#include <husapp.h>
#include <husasynchasher.h>
#include <huscolorgenerator.h>
#include <husiconfont.h>
#include <husrectangle.h>
#include <hussizegenerator.h>
#include <hussystemthemehelper.h>
#include <hustheme.h>
#include <husthemefunctions.h>
#include <huswatermark.h>
#include <huswindowagent.h>
#include <qqml.h>

void HuskarUIPlugin::registerTypes(const char *uri)
{
    // @uri HusegateUI
    qmlRegisterType<HusPen>(uri, 1, 0, "HusPen");
    qmlRegisterType<HusRectangle>(uri, 1, 0, "HusRectangle");
    qmlRegisterType<HusAsyncHasher>(uri, 1, 0, "HusAsyncHasher");
    qmlRegisterType<HusColorGenerator>(uri, 1, 0, "HusColorGenerator");
    qmlRegisterType<HusSizeGenerator>(uri, 1, 0, "HusSizeGenerator");
    qmlRegisterType<HusSystemThemeHelper>(uri, 1, 0, "HusSystemThemeHelper");
    qmlRegisterType<HusWatermark>(uri, 1, 0, "HusWatermark");
    qmlRegisterType<HusWindowAgent>(uri, 1, 0, "HusWindowAgent");

    qmlRegisterSingletonType<HusIcon>(uri, 1, 0, "HusIcon", &HusIcon::create);
    qmlRegisterSingletonType<HusApi>(uri, 1, 0, "HusApi", &HusApi::create);
    qmlRegisterSingletonType<HusApp>(uri, 1, 0, "HusApp", &HusApp::create);
    qmlRegisterSingletonType<HusTheme>(uri, 1, 0, "HusTheme", &HusTheme::create);
    qmlRegisterSingletonType<HusThemeFunctions>(uri, 1, 0, "HusThemeFunctions", &HusThemeFunctions::create);
}

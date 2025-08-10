#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

#include "husapp.h"
#include "datagenerator.h"
#include "themeswitchitem.h"
#include "creator.h"

#ifdef BUILD_DELEGATEUI_STATIC_LIBRARY
#include <QtQml/qqmlextensionplugin.h>
Q_IMPORT_QML_PLUGIN(HuskarUI_BasicPlugin)
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
#else
    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::OpenGL);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
    QQuickWindow::setDefaultAlphaBuffer(true);

    qmlRegisterType<ThemeSwitchItem>("Gallery", 1, 0, "ThemeSwitchItem");
    qmlRegisterSingletonType<DataGenerator>("Gallery", 1, 0, "DataGenerator", &DataGenerator::create);
    qmlRegisterSingletonType<Creator>("Gallery", 1, 0, "Creator", &Creator::create);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("MenPenS");
    app.setApplicationName("HuskarUI");
    app.setApplicationDisplayName("HuskarUI Gallery");

    QQmlApplicationEngine engine;
    HusApp::initialize(&engine);

#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    const QUrl url(u"qrc:/Gallery/qml/Gallery.qml"_qs);
#else
    const QUrl url("qrc:/Gallery/qml/Gallery.qml");
#endif
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

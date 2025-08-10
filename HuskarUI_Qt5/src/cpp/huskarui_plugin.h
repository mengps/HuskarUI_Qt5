#ifndef HUSKARUI_PLUGIN_H
#define HUSKARUI_PLUGIN_H

#include <QQmlExtensionPlugin>

class HuskarUIPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // HUSKARUI_PLUGIN_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "include/stagessystem.h"
#include "include/abstractstage.h"
#include "include/modifyinstallstage.h"
#include "include/installmodestage.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    StagesSystem stagesSystem;

    qmlRegisterType<StagesSystem>("TDS", 1, 0, "StagesSystem");
    qmlRegisterUncreatableType<AbstractStage>("TDS", 1, 0, "AbstractStage", "Abstract class");
    qmlRegisterType<ModifyInstallStage>("TDS", 1, 0, "ModifyInstallStage");
    qmlRegisterType<InstallModeStage>("TDS", 1, 0, "InstallModeStage");
    
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("stagesSystem", &stagesSystem);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

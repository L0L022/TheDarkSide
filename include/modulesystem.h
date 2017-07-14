#ifndef MODULESYSTEM_H
#define MODULESYSTEM_H

#include <QThreadPool>
#include "modulemodel.h"

class ModuleSystem : public QObject
{
    Q_OBJECT
    static constexpr const char *fileInfoName = "info.json", *fileScriptName = "script.sh";
public:
    enum State {
        IdleState,
        LoadState,
        InstallState,
        UninstallState
    };

    ModuleSystem(QObject *parent = nullptr);

    inline State currentState() const { return m_currentState; }

    inline ModuleModel *modules() { return m_modules; }

    void importModules(const QString &path);

signals:
    void currentStateChanged();

private:
    void setCurrentState(const State state);

    void loadModule(const QString &path, const QString &directDependency = "");
    void loadModules(const QString &path, const QString &directDependency = "");

private:
    State m_currentState;
    QThreadPool *m_threadPool;
    ModuleModel *m_modules;
};

#endif // MODULESYSTEM_H

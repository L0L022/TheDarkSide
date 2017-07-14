#ifndef CONFIGMODULESTAGE_H
#define CONFIGMODULESTAGE_H

#include <QPointer>
#include "abstractstage.h"
#include "modulesystem.h"

class ConfigModulesStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit ConfigModulesStage(QObject *parent = nullptr);
    ConfigModulesStage(ModuleSystem *moduleSystem, QObject *parent = nullptr);

    Stages stage() const;

    Q_INVOKABLE inline ModuleModel *modules() { return m_moduleSystem->modules(); }

protected:
    AbstractStage *next();

private:
    QPointer<ModuleSystem> m_moduleSystem;
};

#endif // CONFIGMODULESTAGE_H

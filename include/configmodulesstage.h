#ifndef CONFIGMODULESTAGE_H
#define CONFIGMODULESTAGE_H

#include <QPointer>
#include "abstractstage.h"
#include "modulemodel.h"

class ConfigModulesStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit ConfigModulesStage(QObject *parent = nullptr);
    ConfigModulesStage(ModuleModel *modules, QObject *parent = nullptr);

    Stages stage() const;

    Q_INVOKABLE inline ModuleModel *modules() { return m_modules.data(); }

protected:
    AbstractStage *next();

private:
    QPointer<ModuleModel> m_modules;
};

#endif // CONFIGMODULESTAGE_H

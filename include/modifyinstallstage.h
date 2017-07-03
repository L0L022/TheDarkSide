#ifndef MODIFYINSTALLSTAGE_H
#define MODIFYINSTALLSTAGE_H

#include "abstractstage.h"

class ModifyInstallStage : public AbstractStage
{
    Q_OBJECT
    Q_PROPERTY(Action action READ action WRITE setAction NOTIFY actionChanged)
public:
    enum class Action {
        Reinstall,
        Uninstall,
        ChangeModules
    };
    Q_ENUM(Action)

    explicit ModifyInstallStage(QObject *parent = nullptr);

    Stages stage() const;

    Action action() const;
    void setAction(const Action action);

signals:
    void actionChanged();

protected:
    AbstractStage *next();

private:
    Action m_action;
};

#endif // MODIFYINSTALLSTAGE_H

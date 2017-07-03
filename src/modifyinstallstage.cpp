#include "include/modifyinstallstage.h"
#include "include/uninstallstage.h"
#include "include/configmodulesstage.h"

ModifyInstallStage::ModifyInstallStage(QObject *parent)
    : AbstractStage(parent),
      m_action(Action::ChangeModules)
{}

AbstractStage::Stages ModifyInstallStage::stage() const
{
    return Stages::ModifyInstall;
}

ModifyInstallStage::Action ModifyInstallStage::action() const
{
    return m_action;
}

void ModifyInstallStage::setAction(const Action action)
{
    if (m_action != action) {
        m_action = action;
        emit actionChanged();
    }
}

AbstractStage *ModifyInstallStage::next()
{
    switch (m_action) {
    case Action::ChangeModules:
        return new ConfigModulesStage(this);
        break;
    case Action::Uninstall:
        return new UninstallStage(this);
        break;
    default:
        return nullptr;
        break;
    }
}

#include "include/modifyinstallstage.h"

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
    return nullptr;
}

#include "include/configmodulesstage.h"
#include "include/installstage.h"
#include <QDebug>

ConfigModulesStage::ConfigModulesStage(QObject *parent)
    : AbstractStage(parent),
      m_modules()
{
    m_modules = new ModuleModel(this);
}

ConfigModulesStage::ConfigModulesStage(ModuleModel *modules, QObject *parent)
    : AbstractStage(parent),
      m_modules(modules)
{
    if (!m_modules)
        m_modules = new ModuleModel(this);
}

AbstractStage::Stages ConfigModulesStage::stage() const
{
    return Stages::ConfigModules;
}

AbstractStage *ConfigModulesStage::next()
{
    return new InstallStage(this);
}

#include "include/configmodulesstage.h"
#include "include/installstage.h"
#include <QDebug>

ConfigModulesStage::ConfigModulesStage(QObject *parent)
    : AbstractStage(parent),
      m_moduleSystem()
{
    m_moduleSystem = new ModuleSystem(this);
    //load modules ?
}

ConfigModulesStage::ConfigModulesStage(ModuleSystem *moduleSystem, QObject *parent)
    : AbstractStage(parent),
      m_moduleSystem(moduleSystem)
{
    if (!m_moduleSystem)
        m_moduleSystem = new ModuleSystem(this);
    //load modules ?
}

AbstractStage::Stages ConfigModulesStage::stage() const
{
    return Stages::ConfigModules;
}

AbstractStage *ConfigModulesStage::next()
{
    return new InstallStage(this);
}

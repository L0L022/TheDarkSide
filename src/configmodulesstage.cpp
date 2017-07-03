#include "include/configmodulesstage.h"
#include "include/installstage.h"

ConfigModulesStage::ConfigModulesStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages ConfigModulesStage::stage() const
{
    return Stages::ConfigModules;
}

AbstractStage *ConfigModulesStage::next()
{
    return new InstallStage(this);
}

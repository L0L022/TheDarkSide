#include "include/installstage.h"

InstallStage::InstallStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages InstallStage::stage() const
{
    return Stages::Install;
}

AbstractStage *InstallStage::next()
{
    return nullptr;
}

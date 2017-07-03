#include "include/uninstallstage.h"

UninstallStage::UninstallStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages UninstallStage::stage() const
{
    return Stages::Uninstall;
}

AbstractStage *UninstallStage::next()
{
    return nullptr;
}

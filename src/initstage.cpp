#include "include/initstage.h"
#include "include/welcomestage.h"
#include "include/modifyinstallstage.h"

InitStage::InitStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages InitStage::stage() const
{
    return Stages::Init;
}

AbstractStage *InitStage::next()
{
    //si TDS est installé
    return new ModifyInstallStage(this);
    //sinon
//    return new WelcomeStage(this);
}

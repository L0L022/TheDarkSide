#include "include/welcomestage.h"
#include "include/installmodestage.h"

WelcomeStage::WelcomeStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages WelcomeStage::stage() const
{
    return Stages::Welcome;
}

AbstractStage *WelcomeStage::next()
{
    return new InstallModeStage(this);
}

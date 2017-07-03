#include "include/welcomestage.h"

WelcomeStage::WelcomeStage(QObject *parent)
    : AbstractStage(parent)
{}

AbstractStage::Stages WelcomeStage::stage() const
{
    return Stages::Welcome;
}

AbstractStage *WelcomeStage::next()
{
    return nullptr;
}

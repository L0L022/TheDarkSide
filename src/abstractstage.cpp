#include "include/abstractstage.h"

AbstractStage::AbstractStage(QObject *parent) : QObject(parent)
{
    init();
}

AbstractStage::~AbstractStage()
{
    close();
}

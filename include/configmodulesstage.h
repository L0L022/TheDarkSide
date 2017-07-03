#ifndef CONFIGMODULESTAGE_H
#define CONFIGMODULESTAGE_H

#include "abstractstage.h"

class ConfigModulesStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit ConfigModulesStage(QObject *parent = nullptr);

    Stages stage() const;

protected:
    AbstractStage *next();
};

#endif // CONFIGMODULESTAGE_H

#ifndef WELCOMESTAGE_H
#define WELCOMESTAGE_H

#include "abstractstage.h"

class WelcomeStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit WelcomeStage(QObject *parent = nullptr);

    Stages stage() const;

protected:
    AbstractStage *next();
};

#endif // WELCOMESTAGE_H

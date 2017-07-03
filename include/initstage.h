#ifndef INITSTAGE_H
#define INITSTAGE_H

#include "abstractstage.h"

class InitStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit InitStage(QObject *parent = nullptr);

    Stages stage() const;

protected:
    AbstractStage *next();
};

#endif // INITSTAGE_H

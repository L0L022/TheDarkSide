#ifndef INSTALLSTAGE_H
#define INSTALLSTAGE_H

#include "abstractstage.h"

class InstallStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit InstallStage(QObject *parent = nullptr);

    Stages stage() const;

protected:
    AbstractStage *next();
};

#endif // INSTALLSTAGE_H

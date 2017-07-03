#ifndef UNINSTALLSTAGE_H
#define UNINSTALLSTAGE_H

#include "abstractstage.h"

class UninstallStage : public AbstractStage
{
    Q_OBJECT
public:
    explicit UninstallStage(QObject *parent = nullptr);

    Stages stage() const;

protected:
    AbstractStage *next();
};

#endif // UNINSTALLSTAGE_H

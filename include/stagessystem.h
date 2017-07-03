#ifndef STATESYSTEM_H
#define STATESYSTEM_H

#include <stack>
#include <QObject>
#include "abstractstage.h"

class StagesSystem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(AbstractStage* currentStage READ currentStage NOTIFY currentStageChanged)

public:
    explicit StagesSystem(QObject *parent = nullptr);
    ~StagesSystem();

    AbstractStage *currentStage();

    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void cancel();

signals:
    void currentStageChanged();

private:
    std::stack<AbstractStage*> m_stages;
};

#endif // STATESYSTEM_H

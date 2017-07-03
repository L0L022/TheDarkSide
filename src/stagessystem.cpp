#include "include/stagessystem.h"
#include "include/initstage.h"

StagesSystem::StagesSystem(QObject *parent)
    : QObject(parent)
{
    m_stages.push(new InitStage(this));
    next();
}

StagesSystem::~StagesSystem()
{
}

AbstractStage * StagesSystem::currentStage()
{
    if (m_stages.empty())
        return nullptr;
    else
        return m_stages.top();
}

void StagesSystem::next()
{
    if (currentStage()) {
        auto stage = currentStage()->next();

        if (stage)
            stage->setParent(this);

        if (m_stages.top() != stage) {
            m_stages.push(stage);
            emit currentStageChanged();
        }
    }
}

void StagesSystem::previous()
{
    if (!m_stages.empty()) {
        currentStage()->deleteLater();
        m_stages.pop();
        emit currentStageChanged();
    }
}

void StagesSystem::cancel()
{
//     if (m_state) {
//         m_state->cancel();
//         changeState();
//     }
}

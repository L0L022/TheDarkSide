#ifndef INSTALLMODESTAGE_H
#define INSTALLMODESTAGE_H

#include "abstractstage.h"

class InstallModeStage : public AbstractStage
{
    Q_OBJECT
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged)
public:
    enum class Mode {
        Standard,
        Customize
    };
    Q_ENUM(Mode)

    explicit InstallModeStage(QObject *parent = nullptr);

    Stages stage() const;

    Mode mode() const;
    void setMode(const Mode mode);

signals:
    void modeChanged();

protected:
    AbstractStage *next();

private:
    Mode m_mode;
};


#endif // INSTALLMODESTAGE_H

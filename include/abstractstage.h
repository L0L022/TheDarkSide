#ifndef ABSTRACTSTATE_H
#define ABSTRACTSTATE_H

#include <QObject>

class StagesSystem;

class AbstractStage : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Stages stage READ stage CONSTANT)
public:
    enum class Stages {
        Init,
        Welcome,
        ModifyInstall,
        InstallMode,
        ConfigModules,
        Install,
        InstallFinished,
        Uninstall,
        UninstallFinished
    };
    Q_ENUM(Stages)

    explicit AbstractStage(QObject *parent = nullptr);
    ~AbstractStage();

    virtual Stages stage() const = 0;
    
protected:
    virtual AbstractStage *next() = 0;
    virtual void cancel() {}

    virtual void init() {}
    virtual void close() {}
    
    friend StagesSystem;
};

#endif // ABSTRACTSTATE_H

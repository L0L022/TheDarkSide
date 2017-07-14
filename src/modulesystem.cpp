#include "include/modulesystem.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDir>
#include <QProcess>
#include <QtConcurrent>
#include <QDebug>

ModuleSystem::ModuleSystem(QObject *parent)
    : QObject(parent),
      m_currentState(IdleState)
{
    m_threadPool = new QThreadPool(this);
    m_modules = new ModuleModel(this);
}

void ModuleSystem::importModules(const QString &path)
{
    if (m_currentState == IdleState) {
        setCurrentState(LoadState);
        loadModules(path);
    }
}

void ModuleSystem::setCurrentState(const State state)
{
    if (m_currentState != state) {
        m_currentState = state;
        emit currentStateChanged();
    }
}

void ModuleSystem::loadModule(const QString &path, const QString &directDependency)
{
    QFile fileInfo(path + "/" + fileInfoName);
    if (!fileInfo.open(QIODevice::ReadOnly)) {
        qCritical() << fileInfo.errorString();
        return;
    }

    QJsonParseError jsonError;
    QJsonDocument infoDoc = QJsonDocument::fromJson(fileInfo.readAll(), &jsonError);
    if (jsonError.error != QJsonParseError::NoError) {
        qCritical() << jsonError.errorString();
        return;
    }

    if (!infoDoc.isObject()) {
        qCritical() << "not an object";
        return;
    }

    QJsonObject infoObject = infoDoc.object();

    QStringList dependence = infoObject["dependence"].toVariant().toStringList();
    if (!directDependency.isEmpty())
        dependence.push_front(directDependency);

    QProcess proc;
    proc.setProgram("/home/loic/Info/Github/TheDarkSide/modules/modules/TDSModules.sh");
    proc.setArguments({"/home/loic/Info/Github/TheDarkSide/modules/"+path.mid(1), "info"});
    proc.start();
    proc.waitForFinished();

    //prob qprocess error

    if (proc.exitStatus() != QProcess::NormalExit) {
        qDebug() << proc.readAllStandardError();
        return;
    }

    QMap<QString, QString> variables;
    while (proc.canReadLine()) {
        QString line(proc.readLine().trimmed());
        int eqPos = line.indexOf('=');
        if (eqPos > 1)
            variables[line.left(eqPos)] = line.mid(eqPos + 1);
    }

    bool isInstalled = variables["IS_INSTALLED"] == "true";

    m_modules->append(ModuleItem(path,
                                 infoObject["id"].toString(),
                                 infoObject["name"].toString(),
                                 infoObject["description"].toString(),
                                 infoObject["category"].toString(),
                                 variables["INSTALLED_VERSION"],
                                 variables["LAST_VERSION"],
                                 directDependency,
                                 dependence,
                                 !QDir(path).entryList(QDir::Dirs | QDir::NoDotAndDotDot).empty(),
                                 isInstalled));

    loadModules(path, infoObject["id"].toString());
}

void ModuleSystem::loadModules(const QString &path, const QString &directDependency)
{
    auto dirs = QDir(path).entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    auto canonicalPath = QDir(path).canonicalPath() + "/";
    for (const QString &dir : dirs)
        QtConcurrent::run(m_threadPool, this, &ModuleSystem::loadModule, canonicalPath + dir, directDependency);
}

#include "include/modulemodel.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QDir>
#include <QReadLocker>
#include <QWriteLocker>

ModuleItem::ModuleItem(const QString &path, const QString &id, const QString &name,
                       const QString &description, const QString &category, const QString &installedVersion,
                       const QString &latestVersion, const QString &directDependency, const QStringList &dependence,
                       const bool hasSubModules, const bool isEnabled)
    : m_path(path), m_id(id), m_name(name), m_description(description), m_category(category),
      m_installedVersion(installedVersion), m_latestVersion(latestVersion), m_directDependency(directDependency),
      m_dependence(dependence), m_hasSubModules(hasSubModules), m_isEnabled(isEnabled)
{}

ModuleModel::ModuleModel(QObject *parent)
    : QAbstractListModel(parent)
{}

void ModuleModel::append(const ModuleItem &module)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    QWriteLocker locker(&m_lock);
    m_modules.append(module);
    endInsertRows();
}

void ModuleModel::removeAt(const int index)
{
    QWriteLocker locker(&m_lock);

    if (0 > index || index > m_modules.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_modules.removeAt(index);
    endRemoveRows();
}

void ModuleModel::clear()
{
    QWriteLocker locker(&m_lock);

    beginResetModel();
    m_modules.clear();
    endResetModel();
}

ModuleItem ModuleModel::at(const int index) const
{
    QReadLocker locker(const_cast<QReadWriteLock*>(&m_lock));
    return m_modules.at(index);
}

QVariant ModuleModel::data(const QModelIndex &index, int role) const
{
    QReadLocker locker(const_cast<QReadWriteLock*>(&m_lock));

    if (!index.isValid() || index.row() >= m_modules.count())
        return QVariant();

    auto module = m_modules.at(index.row());

    if (role == PathRole)
        return module.path();
    else if (role == IdRole)
        return module.id();
    else if (role == NameRole)
        return module.name();
    else if (role == DescriptionRole)
        return module.description();
    else if (role == CategoryRole)
        return module.category();
    else if (role == InstalledVersionRole)
        return module.installedVersion();
    else if (role == LatestVersionRole)
        return module.latestVersion();
    else if (role == DirectDependencyRole)
        return module.directDependency();
    else if (role == DependenceRole)
        return module.dependence();
    else if (role == HasSubModulesRole)
        return module.hasSubModules();
    else if (role == IsEnabledRole)
        return module.isEnabled();

    return QVariant();
}

int ModuleModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    QReadLocker locker(const_cast<QReadWriteLock*>(&m_lock));
    return m_modules.count();
}

QHash<int, QByteArray> ModuleModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PathRole] = "pathRole";
    roles[IdRole] = "idRole";
    roles[NameRole] = "nameRole";
    roles[DescriptionRole] = "descriptionRole";
    roles[CategoryRole] = "categoryRole";
    roles[InstalledVersionRole] = "installedVersionRole";
    roles[LatestVersionRole] = "latestVersionRole";
    roles[DirectDependencyRole] = "directDependencyRole";
    roles[DependenceRole] = "dependenceRole";
    roles[HasSubModulesRole] = "hasSubModulesRole";
    roles[IsEnabledRole] = "isEnabledRole";
    return roles;
}

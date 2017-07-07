#include "include/modulemodel.h"
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QDir>

ModuleItem::ModuleItem(const QString &path, QObject *parent)
    : QObject(parent),
      m_path(path),
      m_isEnabled(false)
{
    QFile fileInfo(m_path + "/" + fileInfoName);
    if (!fileInfo.open(QIODevice::ReadOnly)) {
        //prob
    }

    QTextStream infoStream(&fileInfo);
    QJsonDocument infoDoc = QJsonDocument::fromJson(infoStream.readAll().toUtf8());

    if (!infoDoc.isObject()) {
        //prob
    }

    QJsonObject infoObject = infoDoc.object();
    m_id = infoObject["id"].toString();
    m_name = infoObject["name"].toString();
    m_description = infoObject["description"].toString();
    m_category = infoObject["category"].toString();
    m_dependence = infoObject["dependence"].toVariant().toStringList();

    m_hasSubModules = !QDir(path).entryList(QDir::Dirs | QDir::NoDotAndDotDot).empty();
}

void ModuleItem::setEnabled(const bool enabled)
{
    if (enabled != m_isEnabled) {
        m_isEnabled = enabled;
        emit isEnabledChanged();
    }
}

ModuleModel::ModuleModel(QObject *parent)
    : QAbstractListModel(parent)
{}

void ModuleModel::append(const QString &path)
{
    //FIXME check path
    ModuleItem *module = new ModuleItem(path, this);

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_modules.append(module);
    endInsertRows();
}

void ModuleModel::removeAt(const int index)
{
    if (0 > index || index > m_modules.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    delete m_modules[index].data();
    m_modules.removeAt(index);
    endRemoveRows();
}

void ModuleModel::clear()
{
    beginResetModel();
    for (auto module : m_modules)
        delete module.data();
    endResetModel();
}

void ModuleModel::loadFromDir(const QString &path)
{
    auto dirs = QDir(path).entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    auto canonicalPath = QDir(path).canonicalPath() + "/";
    for (const QString &dir : dirs) {
        append(canonicalPath + dir);
        loadFromDir(canonicalPath + dir);
    }
}

QVariant ModuleModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_modules.count())
        return QVariant();

    auto module = m_modules.at(index.row());
    if (!module)
        return QVariant();

    if (role == ModuleRole)
        return QVariant::fromValue(module.data());
    else if (role == PathRole)
        return module->path();
    else if (role == IdRole)
        return module->id();
    else if (role == NameRole)
        return module->name();
    else if (role == DescriptionRole)
        return module->description();
    else if (role == CategoryRole)
        return module->category();
    else if (role == DependenceRole)
        return module->dependence();
    else if (role == HasSubModulesRole)
        return module->hasSubModules();

    return QVariant();
}

int ModuleModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_modules.count();
}

QHash<int, QByteArray> ModuleModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ModuleRole] = "moduleRole";
    roles[PathRole] = "pathRole";
    roles[IdRole] = "idRole";
    roles[NameRole] = "nameRole";
    roles[DescriptionRole] = "descriptionRole";
    roles[CategoryRole] = "categoryRole";
    roles[DependenceRole] = "dependenceRole";
    roles[HasSubModulesRole] = "hasSubModulesRole";
    return roles;
}

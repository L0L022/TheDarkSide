#ifndef MODULEMODEL_H
#define MODULEMODEL_H

#include <QAbstractListModel>
#include <QReadWriteLock>

class ModuleItem
{
public:
    ModuleItem(const QString &path, const QString &id, const QString &name,
               const QString &description, const QString &category,
               const QString &installedVersion, const QString &latestVersion,
               const QString &directDependency, const QStringList &dependence,
               const bool hasSubModules, const bool isEnabled);

    inline QString path() const { return m_path; }
    inline QString id() const { return m_id; }
    inline QString name() const { return m_name; }
    inline QString description() const { return m_description; }
    inline QString category() const { return m_category; }
    inline QString installedVersion() const { return m_installedVersion; }
    inline QString latestVersion() const { return m_latestVersion; }
    inline QString directDependency() const { return m_directDependency; }
    inline QStringList dependence() const { return m_dependence; }
    inline bool hasSubModules() const { return m_hasSubModules; }
    inline bool isEnabled() const { return m_isEnabled; }

private:
    QString m_path, m_id, m_name, m_description, m_category, m_installedVersion, m_latestVersion, m_directDependency;
    QStringList m_dependence;
    bool m_hasSubModules, m_isEnabled;
};

class ModuleModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ModuleRoles {
        PathRole = Qt::UserRole + 1,
        IdRole,
        NameRole,
        DescriptionRole,
        CategoryRole,
        InstalledVersionRole,
        LatestVersionRole,
        DirectDependencyRole,
        DependenceRole,
        HasSubModulesRole,
        IsEnabledRole
    };
    Q_ENUM(ModuleRoles)

    ModuleModel(QObject *parent = nullptr);

    void append(const ModuleItem &module);
    void removeAt(const int index);
    void clear();

    ModuleItem at(const int index) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex & parent = QModelIndex()) const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<ModuleItem> m_modules;
    QReadWriteLock m_lock;
};

#endif // MODULEMODEL_H

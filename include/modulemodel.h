#ifndef MODULEMODEL_H
#define MODULEMODEL_H

#include <QPointer>
#include <QDir>
#include <QAbstractListModel>

class ModuleItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path CONSTANT)
    Q_PROPERTY(QString id READ id CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString description READ description CONSTANT)
    Q_PROPERTY(QString category READ category CONSTANT)
    Q_PROPERTY(QString installedVersion READ installedVersion NOTIFY installedVersionChanged)
    Q_PROPERTY(QString latestVersion READ latestVersion NOTIFY latestVersionChanged)
    Q_PROPERTY(QStringList dependence READ dependence CONSTANT)
    Q_PROPERTY(bool hasSubModules READ hasSubModules CONSTANT)
    Q_PROPERTY(bool isEnabled READ isEnabled WRITE setEnabled NOTIFY isEnabledChanged)

public:
    static constexpr const char *fileInfoName = "info.json", *fileScriptName = "scripts.bash";

    ModuleItem(const QString &path, QObject *parent = nullptr);

    inline QString path() const { return m_path; }
    inline QString id() const { return m_id; }
    inline QString name() const { return m_name; }
    inline QString description() const { return m_description; }
    inline QString category() const { return m_category; }
    inline QString installedVersion() const { return m_installedVersion; }
    inline QString latestVersion() const { return m_latestVersion; }
    inline QStringList dependence() const { return m_dependence; }
    inline bool hasSubModules() const { return m_hasSubModules; }

    inline bool isEnabled() const { return m_isEnabled; }
    void setEnabled(const bool enabled);

signals:
    void installedVersionChanged();
    void latestVersionChanged();
    void isEnabledChanged();

private:
    QString m_path, m_id, m_name, m_description, m_category, m_installedVersion, m_latestVersion;
    QStringList m_dependence;
    bool m_hasSubModules, m_isEnabled;
};

class ModuleModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ModuleRoles {
        ModuleRole = Qt::UserRole + 1,
        PathRole,
        IdRole,
        NameRole,
        DescriptionRole,
        CategoryRole,
        DependenceRole,
        HasSubModulesRole
    };
    Q_ENUM(ModuleRoles)

    ModuleModel(QObject *parent = nullptr);

    void append(const QString &path);
    void removeAt(const int index);
    void clear();

    void loadFromDir(const QString &path);

    inline const ModuleItem *at(const int index) const { return m_modules.at(index); }
    inline ModuleItem *operator[](const int index) { return m_modules[index]; }

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex & parent = QModelIndex()) const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<QPointer<ModuleItem>> m_modules;
};

#endif // MODULEMODEL_H

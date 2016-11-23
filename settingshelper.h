#ifndef SETTINGSHELPER_H
#define SETTINGSHELPER_H

#include <QObject>
#include <QVariant>
#include <QSettings>

class SettingsHelper : public QObject
{
    Q_OBJECT
public:
    explicit SettingsHelper(QObject *parent = 0);
    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE QVariant getValue(const QString &key, const QVariant &defaultValue = QVariant()) const;
    Q_INVOKABLE bool getBoolValue(const QString &key, const bool defaultValue);
signals:

public slots:
};

#endif // SETTINGSHELPER_H

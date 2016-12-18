#include "settingshelper.h"
#include <QDebug>
SettingsHelper::SettingsHelper(QObject *parent) : QObject(parent)
{

}

void SettingsHelper::setValue(const QString &key, const QVariant &value)
{
    QSettings settings;
    qDebug() << "Setting" << key << "=" << value << "(location:" << settings.fileName();
    settings.setValue(key, value);
}

QVariant SettingsHelper::getValue(const QString &key, const QVariant &defaultValue) const
{
    QSettings settings;
    QVariant value = settings.value(key, defaultValue);
    return value;
}

bool SettingsHelper::getBoolValue(const QString &key, const bool defaultValue)
{
    QSettings settings;
    return settings.value(key, defaultValue).toBool();
}

int SettingsHelper::getIntValue(const QString &key, const bool defaultValue)
{
    QSettings settings;
    return settings.value(key, defaultValue).toInt();
}

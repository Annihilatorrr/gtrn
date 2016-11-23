#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "soundplayer.h"
#include "settingshelper.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("oleumsoft");
    app.setOrganizationDomain("oleumsoft.com");
    app.setApplicationName("guitartrainer");

    qmlRegisterType<SettingsHelper>("oleumsoft.com.utils", 1, 0, "SettingsHelper");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *rootObject = engine.rootObjects().first();
    auto ss = rootObject->objectName();
    QObject *qmlObject = rootObject->findChild<QObject*>("FretboardObject");
    int x = qmlObject->property("x").toInt();

    qDebug() << engine.importPathList();
    SoundPlayer myClass;
        QObject::connect(qmlObject, SIGNAL(notePressed(int, QString)),
                         &myClass, SLOT(onNotePressed(int, QString)));
    return app.exec();
}

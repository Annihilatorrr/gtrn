#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "soundplayer.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *rootObject = engine.rootObjects().first();
    auto ss = rootObject->objectName();
    QObject *qmlObject = rootObject->findChild<QObject*>("FretboardObject");
    int x = qmlObject->property("x").toInt();

    SoundPlayer myClass;
        QObject::connect(qmlObject, SIGNAL(notePressed(int, QString)),
                         &myClass, SLOT(onNotePressed(int, QString)));
    return app.exec();
}

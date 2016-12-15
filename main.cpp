#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "soundplayer.h"
#include "settingshelper.h"
#include "notecontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("oleumsoft");
    app.setOrganizationDomain("oleumsoft.com");
    app.setApplicationName("guitartrainer");

    //qmlRegisterType<SettingsHelper>("oleumsoft.com.utils", 1, 0, "SettingsHelper");
    //qmlRegisterType<NoteController>("oleumsoft.com.utils", 1, 0, "NoteController");
    QQmlApplicationEngine engine;
    QScopedPointer<NoteController> noteController(new NoteController);
    QScopedPointer<SettingsHelper> settingsHelper(new SettingsHelper);

    engine.rootContext()->setContextProperty("noteController", noteController.data());
    engine.rootContext()->setContextProperty("settingsHelper", settingsHelper.data());

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *rootObject = engine.rootObjects().first();
    auto ss = rootObject->objectName();
    QObject *qmlObject = rootObject->findChild<QObject*>("FretboardObject");
    //int x = qmlObject->property("x").toInt();

    //qDebug() << engine.importPathList();
    QScopedPointer<SoundPlayer> soundPlayer(new SoundPlayer);
    //QObject::connect(qmlObject, SIGNAL(notePressed(int, QString)), soundPlayer.data(), SLOT(onNotePressed(int, QString)));



    //QObject::connect(noteController.data(), SIGNAL(displayNonLabeledNote(int, QVariant)), qmlObject, SLOT(displayNonLabeledNote(int, QVariant)));
    noteController->startGame();
    return app.exec();
}

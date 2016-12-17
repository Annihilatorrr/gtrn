#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTime>
#include "soundplayer.h"
#include "settingshelper.h"
#include "notetrainer.h"

int main(int argc, char *argv[])
{
    qsrand(QTime::currentTime().msec());
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("oleumsoft");
    app.setOrganizationDomain("oleumsoft.com");
    app.setApplicationName("guitartrainer");

    //qmlRegisterType<SettingsHelper>("oleumsoft.com.utils", 1, 0, "SettingsHelper");
    //qmlRegisterType<NoteController>("oleumsoft.com.utils", 1, 0, "NoteController");
    QQmlApplicationEngine engine;
    QScopedPointer<NoteTrainer> noteTrainer(new NoteTrainer);
    QScopedPointer<SettingsHelper> settingsHelper(new SettingsHelper);
    QScopedPointer<SoundPlayer> soundPlayer(new SoundPlayer);

    engine.rootContext()->setContextProperty("noteTrainer", noteTrainer.data());
    engine.rootContext()->setContextProperty("settingsHelper", settingsHelper.data());
    engine.rootContext()->setContextProperty("soundPlayer", soundPlayer.data());

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *rootObject = engine.rootObjects().first();
    auto ss = rootObject->objectName();
    QObject *qmlObject = rootObject->findChild<QObject*>("FretboardObject");
    //int x = qmlObject->property("x").toInt();

    //qDebug() << engine.importPathList();
//    QScopedPointer<SoundPlayer> soundPlayer(new SoundPlayer);
//    QObject::connect(qmlObject, SIGNAL(notePressed(int, QString)), soundPlayer.data(), SLOT(onNotePressed(int, QString)));



    //QObject::connect(noteController.data(), SIGNAL(displayNonLabeledNote(int, QVariant)), qmlObject, SLOT(displayNonLabeledNote(int, QVariant)));
    //noteController->startGame();
    return app.exec();
}

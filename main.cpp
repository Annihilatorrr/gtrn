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

    QQmlApplicationEngine engine;
    QScopedPointer<NoteTrainer> noteTrainer(new NoteTrainer);
    QScopedPointer<SettingsHelper> settingsHelper(new SettingsHelper);
    QScopedPointer<SoundPlayer> soundPlayer(new SoundPlayer);

    engine.rootContext()->setContextProperty("noteTrainer", noteTrainer.data());
    engine.rootContext()->setContextProperty("settingsHelper", settingsHelper.data());
    engine.rootContext()->setContextProperty("soundPlayer", soundPlayer.data());

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}

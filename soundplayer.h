#ifndef SOUNDPLAYER_H
#define SOUNDPLAYER_H

#include <QDebug>
#include <QSound>
#include <QMediaPlayer>

class SoundPlayer:public QObject
{
    Q_OBJECT


   QMediaPlayer *m_player = new QMediaPlayer();

   public:
    SoundPlayer(QObject* parent = nullptr);

    public slots:
    void onNotePressed(int octave, const QString &msg);

};

#endif // SOUNDPLAYER_H

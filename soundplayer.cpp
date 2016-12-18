#include "soundplayer.h"


SoundPlayer::SoundPlayer(QObject* parent):QObject(parent)
{
    m_player->setVolume(150);
}

void SoundPlayer::onNotePressed(int octave, const QString &note)
{
    QString normalizeNoteName = note;
    normalizeNoteName.replace(QString("#"), QString("sharp"));
    QString fileName = QString("qrc:/Content/Notes/%1%2.mp3").arg(normalizeNoteName, QString::number(octave));

    m_player->setMedia(QUrl(fileName));

    m_player->play();
}

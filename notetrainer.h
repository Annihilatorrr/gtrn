#ifndef NOTETRAINER_H
#define NOTETRAINER_H

#include <QObject>
#include <QVariant>
class NoteTrainer : public QObject
{
    Q_OBJECT

    QString m_expectedNoteName;
public:
    explicit NoteTrainer(QObject *parent = 0);
    void startGame();

    Q_INVOKABLE void onNotePlayed(int octave, const QString note);
signals:
    void correctNoteDetected(int octave, const QString name);
public slots:
};

#endif // NOTETRAINER_H

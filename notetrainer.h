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

    Q_INVOKABLE void onStartTraining();
    Q_INVOKABLE void onNotePlayed(int octave, const QString note);
signals:
    void correctNoteDetected(int octave, const QString name);
    void displayNonLabeledNote(int stringNumber, int noteNumber);
public slots:
};

#endif // NOTETRAINER_H

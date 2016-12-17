#ifndef NOTETRAINER_H
#define NOTETRAINER_H

#include <QObject>
#include <QVariant>

struct NotePosition
{
    int stringNumber;
    int fretNumber;
};

class NoteTrainer : public QObject
{
    Q_OBJECT

    int m_maxFretNumber;
    int m_maxStringNumber;
public:
    explicit NoteTrainer(QObject *parent = 0);

    Q_INVOKABLE void onStartTraining(int maxStringNumber, int maxFretNumber);
    Q_INVOKABLE void onGetNextNote();

    void updateSettings(int maxStringNumber, int maxFretNumber);
    NotePosition getRandomNote();
signals:
    void correctNoteDetected(int octave, const QString name);
    void displayNonLabeledNote(int stringPosition, int fretPosition);
public slots:
};

#endif // NOTETRAINER_H

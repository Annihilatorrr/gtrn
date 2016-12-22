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

    bool m_isRunning = false;
public:
    explicit NoteTrainer(QObject *parent = 0);

    Q_INVOKABLE void onStartTraining(int maxStringNumber, int maxFretNumber);
    Q_INVOKABLE void onStopTraining();
    Q_INVOKABLE void onGetNextNote();
    Q_INVOKABLE void onContinueWithNewSettings(int maxStringNumber, int maxFretNumber);

    void updateSettings(int maxStringNumber, int maxFretNumber);
    NotePosition getRandomNote();
signals:
    void displayNonLabeledNote(int stringPosition, int fretPosition);
public slots:
};

#endif // NOTETRAINER_H

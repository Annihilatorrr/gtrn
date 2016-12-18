#include "notetrainer.h"
#include <QTimer>

NoteTrainer::NoteTrainer(QObject *parent) : QObject(parent)
{

}

void NoteTrainer::onStartTraining(int maxStringNumber, int maxFretNumber)
{
    qDebug("C++: NoteTrainer::onStartTraining");
    m_maxFretNumber = maxFretNumber;
    m_maxStringNumber = maxStringNumber;

   QTimer::singleShot(100, [this]()
   {
        NotePosition np = getRandomNote();
        emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
    });

}

void NoteTrainer::onGetNextNote()
{
    NotePosition np = getRandomNote();
    emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
}

void NoteTrainer::onUpdateSettings(int maxStringNumber, int maxFretNumber)
{
    qDebug("C++: NoteTrainer::updateSettings");
    m_maxFretNumber = maxFretNumber;
    m_maxStringNumber = maxStringNumber;
}

NotePosition NoteTrainer::getRandomNote()
{
    return {1 + qrand() % m_maxStringNumber, 1 + qrand() % m_maxFretNumber};
}

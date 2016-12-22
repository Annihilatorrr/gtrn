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
    m_isRunning = true;
   QTimer::singleShot(100, [this]()
   {
        NotePosition np = getRandomNote();
        emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
    });
}

void NoteTrainer::onStopTraining()
{
    //m_isRunning = false;
    //qDebug("C++: NoteTrainer::onStopTraining");
}

void NoteTrainer::onGetNextNote()
{
    NotePosition np = getRandomNote();
    emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
}

void NoteTrainer::updateSettings(int maxStringNumber, int maxFretNumber)
{
    qDebug("C++: NoteTrainer::updateSettings");
    m_maxFretNumber = maxFretNumber;
    m_maxStringNumber = maxStringNumber;
}

NotePosition NoteTrainer::getRandomNote()
{
    return {1 + qrand() % m_maxStringNumber, 1 + qrand() % m_maxFretNumber};
}

void NoteTrainer::onContinueWithNewSettings(int maxStringNumber, int maxFretNumber)
{
    if (maxStringNumber != m_maxStringNumber || maxFretNumber != m_maxFretNumber)
    {
        updateSettings(maxStringNumber, maxFretNumber);
        if (m_isRunning)
        {
            QTimer::singleShot(100, [this]()
            {
                 NotePosition np = getRandomNote();
                 emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
             });
        }
    }
}


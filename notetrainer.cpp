#include "notetrainer.h"
#include <QTimer>
NoteTrainer::NoteTrainer(QObject *parent) : QObject(parent)
{

}

void NoteTrainer::onStartTraining(int maxStringNumber, int maxFretNumber)
{
    m_maxFretNumber = maxFretNumber;
    m_maxStringNumber = maxStringNumber;

    QTimer *timer = new QTimer(this);
//    connect(timer, &QTimer::timeout, this, [=,this]
//    {
//        int randomString =  1 + qrand() % maxStringNumber;
//        int randomFret =  1 + qrand() % maxFretNumber;
//        emit displayNonLabeledNote(randomString, randomFret);
//    });
    //timer->start(10000);
    QTimer::singleShot(0, [this](){
        NotePosition np = getRandomNote();
        emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
    });

}

void NoteTrainer::onGetNextNote()
{
    NotePosition np = getRandomNote();
    emit displayNonLabeledNote(np.stringNumber, np.fretNumber);
}

void NoteTrainer::updateSettings(int maxStringNumber, int maxFretNumber)
{
    m_maxFretNumber = maxFretNumber;
    m_maxStringNumber = maxStringNumber;
}

NotePosition NoteTrainer::getRandomNote()
{
    return {1 + qrand() % m_maxStringNumber, 1 + qrand() % m_maxFretNumber};
}

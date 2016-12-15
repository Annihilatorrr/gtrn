#include "notetrainer.h"

NoteTrainer::NoteTrainer(QObject *parent) : QObject(parent)
{

}

void NoteTrainer::startGame()
{
    //emit displayNonLabeledNote(2, "C#");
}

void NoteTrainer::onNotePlayed(int octave, const QString name)
{
    emit correctNotDetected(octave, name);
}

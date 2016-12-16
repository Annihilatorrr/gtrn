#include "notetrainer.h"

NoteTrainer::NoteTrainer(QObject *parent) : QObject(parent)
{

}

void NoteTrainer::onStartTraining()
{
    emit displayNonLabeledNote(2, 3);
}

void NoteTrainer::onNotePlayed(int octave, const QString name)
{
    emit correctNoteDetected(octave, name);
}

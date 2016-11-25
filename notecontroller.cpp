#include "notecontroller.h"

NoteController::NoteController(QObject *parent) : QObject(parent)
{

}

void NoteController::startGame()
{
    emit displayNonLabeledNote(2, "C#");
}

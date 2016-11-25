#ifndef NOTECONTROLLER_H
#define NOTECONTROLLER_H

#include <QObject>
#include <QVariant>
class NoteController : public QObject
{
    Q_OBJECT
public:
    explicit NoteController(QObject *parent = 0);
    void startGame();
signals:
    void displayNonLabeledNote(int octave, const QString note);
public slots:
};

#endif // NOTECONTROLLER_H

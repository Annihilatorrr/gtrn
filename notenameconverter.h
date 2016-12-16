#ifndef NOTENAMECONVERTER_H
#define NOTENAMECONVERTER_H

#include <QMultiMap>

struct NotePosition
{
    int fretNumber;
    int stringNumber;
};

class NoteNameConverter
{
    int m_stringsCount = 6;
    int m_fretsCount = 24;
    int initialOctave = 2;
    QString m_notesName[]{"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    QMultiMap<QString, NotePosition> m_notesNamesMapping;
    int m_notesPositions[6][24];
public:
    NoteNameConverter();
    QString getNoteNameByPosition(int fretNumber, int stringNumber);
};

#endif // NOTENAMECONVERTER_H

#include "notenameconverter.h"

NoteNameConverter::NoteNameConverter()
{
    for (int i:m_stringsCount)
    {
        for (int j:m_fretsCount)
        {
            m_notesNamesMapping.insert()
        }
    }
//        var settings = {
//            "x": fretDistances[i] + fretThickness/2,
//            "y": 0,
//            "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
//            "height": activeAreaHeight,
//            "backgroundColor":"blue",
//            "octave":octaveCounter,
//            "name":notesNames[initialNoteIndex%12],
//            "normalLabelRadius":10,
//            "normalLabelBackgroundColor":'#AAFFA500',
//            "normalLabelBorderColor":'#C11B17',
//            "normalLabelTextColor":"#FFFFFF"
//        };

//        if (initialNoteIndex%12 == 0 && initialNoteIndex != 0)
//        {
//            ++octaveCounter;
//        }

//        var component = Qt.createComponent("qrc:/Note.qml");
//        notes[i] = component.createObject(stringItem,settings);
//        notes[i].notePressed.connect(notePressed);
//        notes[i].notePressed.connect(onNotePressed);
//        notes[i].showNotesLabels = showNotesLabels;
//    }
}

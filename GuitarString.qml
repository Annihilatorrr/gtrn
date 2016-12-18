import QtQuick 2.0
import "Content/Scripts/GuitarString.js" as GuitarJs
Item {
    id:stringItem
    property var fretDistances:[]
    property string initialNote:"E"
    property int stringInitialNoteOctave:1
    property int activeAreaHeight
    property int fretThickness
    property int stringWidth:3
    property var notes:[]

    signal notePressed(int octave, string name)
    signal nonLabeledDisplayingStopped();

    property bool showNotesLabels:true
    property var notesNames:["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

    onStringWidthChanged: guitarStringCanvas.requestPaint()


    SequentialAnimation {
        loops: 40
        running: false

        id: sequentialStringWidthAnimation
        NumberAnimation {
                id: stringWidthUpAnimation
                target: stringItem
                properties: "stringWidth"
                from: 4
                to: 8
                duration: 30
                easing {type: Easing.OutCubic}
           }
        // Then pause for 500ms
        NumberAnimation {
                id:stringWidthDownAnimation
                target: stringItem
                properties: "stringWidth"
                to: 4
                from: 8
                duration: 30
                easing {type: Easing.OutCubic}
           }
    }

    Canvas {
        id:guitarStringCanvas
        width: parent.width
        height: parent.height
        antialiasing: true
        onPaint: GuitarJs.drawString(guitarStringCanvas)
    }

    onShowNotesLabelsChanged:
    {
        var notesNumber = fretDistances.length
        for (var i = 0; i < notesNumber - 1 ; ++i)
        {
            notes[i].setVisible(showNotesLabels);
        }
        guitarStringCanvas.requestPaint()
    }

    Component.onCompleted:{
        guitarStringCanvas.requestPaint()
        GuitarJs.createNotes(activeAreaHeight, fretThickness);
    }

    function displayNonLabeledNote(fretPosition)
    {
        notes[fretPosition].displayNonLabeled();
        var noteName = notes[fretPosition].name;
        console.debug("displayNonLabeled:", noteName);
        return noteName;
    }

    function displayNonLabeledNoteAsWrong(fretPosition)
    {
        if (notes[fretPosition] !== undefined)
        {
            notes[fretPosition].displayNonLabeledNoteAsWrong();
        }
        else // it can be if a user cuts down fret number so that current note appears to be out of bound
        {
            nonLabeledDisplayingStopped();
        }

    }

    function displayNonLabeledNoteAsRight(fretPosition)
    {
        if (notes[fretPosition] !== undefined)
        {
            notes[fretPosition].displayNonLabeledNoteAsRight();
        }
        else // it can be if a user cuts down fret number so that current note appears to be out of bound
        {
            nonLabeledDisplayingStopped();
        }
    }
}

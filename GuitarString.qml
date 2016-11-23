import QtQuick 2.0
import "Content/Scripts/GuitarString.js" as GuitarJs
Item {
    id:stringItem
    property variant fretDistances:[]
    property string initialNote:"E"
    property int initialNoteOctave:1
    property int activeAreaHeight
    property int fretThickness
    property int stringWidth:2
    property var notes:[]
    signal notePressed(int octave, string name)
    property bool showNotesLabels:true
    property variant notesNames:["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", ]

    onStringWidthChanged: guitarStringCanvas.requestPaint()


    SequentialAnimation {
        loops: 40
        running: false

        id: sequentialStringWidthAnimation
        NumberAnimation {
                id: stringWidthUpAnimation
                target: stringItem
                properties: "stringWidth"
                from: 2
                to: 3
                duration: 70
                easing {type: Easing.OutCubic}
           }
        // Then pause for 500ms
        NumberAnimation {
                id:stringWidthDownAnimation
                target: stringItem
                properties: "stringWidth"
                to: 2
                from: 3
                duration: 70
                easing {type: Easing.OutCubic}
           }
    }

    Canvas {
        id:guitarStringCanvas
        width: parent.width
        height: parent.height
        onPaint: GuitarJs.drawString(guitarStringCanvas)
    }

    onShowNotesLabelsChanged:
    {
        var notesNumber = fretDistances.length
        for (var i = 0; i < notesNumber - 1 ; ++i)
            notes[i].showNotesLabels = showNotesLabels;
        guitarStringCanvas.requestPaint()
    }

    Component.onCompleted:{
        GuitarJs.createNotes(activeAreaHeight, fretThickness);
    }
}

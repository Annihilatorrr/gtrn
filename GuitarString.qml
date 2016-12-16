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
            notes[i].showNotesLabels = showNotesLabels;
        guitarStringCanvas.requestPaint()
    }

    Component.onCompleted:{
        guitarStringCanvas.requestPaint()
        GuitarJs.createNotes(activeAreaHeight, fretThickness);
    }
}

import QtQuick 2.0
import "Content/Scripts/GuitarString.js" as GuitarJs
Item {
    id:stringItem

    QtObject {
        id: d

        property var notesNames:["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    }

//    Rectangle
//    {
//        id:debugRectangle
//        anchors.fill: parent
//        color:"orange"
//    }
    property var fretDistances:[]
    property string initialNote:"E"
    property int stringInitialNoteOctave:1

    property int fretThickness
    property int oscillationAmplitude:height/2
    property int stringThickness:3
    property int activeFretsNumber
    property var notes:[]

    signal notePressed(int octave, string name)
    signal nonLabeledDisplayingStopped();

    property bool showNotesLabels:true

    onStringThicknessChanged: guitarStringCanvas.requestPaint()
    SequentialAnimation
    {
        id: stringOscillationAnimation
        running: false
        loops:1
        alwaysRunToEnd:false
        SpringAnimation
        {
            id: ocillationUpAnimation
            target: stringItem
            property: "oscillationAmplitude"
            spring: 5;
            from:height/2-3
            to:height/2
            damping: 0.0005
            duration:1
            velocity:5000
            mass:0.024
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
        for (var i = 0; i < notesNumber ; ++i)
        {
            notes[i].showLabels(showNotesLabels);
        }
        guitarStringCanvas.requestPaint()
    }

    onOscillationAmplitudeChanged:
    {
        console.debug("onOscillationAmplitudeChanged", oscillationAmplitude);
        guitarStringCanvas.requestPaint()
    }

    Component.onCompleted:{
        guitarStringCanvas.requestPaint()
        GuitarJs.createNotes(height, fretThickness);
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

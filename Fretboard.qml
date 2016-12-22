import QtQuick 2.0
import QtQuick.Controls 1.4


import "Content/Scripts/Fretboard.js" as FretboardJs
Item {
    id: fretBoardItem

    property color backgroundColor:"#D2691E"
    property color fretMarkerColor: "#ffffff"
    property int fretsNumber:22
    property int stringNumber:tuning.length
    property int fretThickness:3
    property bool isMuted:false
    property bool showNotesLabels:true
    property bool trainingMode:false
    property int edgeMargin:10
    property int labelHeight:20
    property var strings:[]
    property var tuning:[]

    QtObject {
        id: d

        property int currentNonLabeledNoteStringIndex
        property int currentNonlabeledNoteFretIndex
        property var absoluteFretDistances:[]
    }

    signal notePressed(int octave, string name)
    signal nonlabeledNoteDisplayed(var noteName)
    signal nonLabeledDisplayingStopped();
    signal displayNonLabeledNoteAsWrong();
    signal displayNonLabeledNoteAsRight();

    Connections{
        target:noteTrainer

        onDisplayNonLabeledNote:
        {
            if (trainingMode)
            {
                d.currentNonLabeledNoteStringIndex = stringPosition;
                d.currentNonlabeledNoteFretIndex = fretPosition
                console.debug("Note to display nonlabeled", d.currentNonLabeledNoteStringIndex, d.currentNonlabeledNoteFretIndex);
                var displayedNoteName = strings[d.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNote(d.currentNonlabeledNoteFretIndex);
                nonlabeledNoteDisplayed(displayedNoteName);
            }
        }
    }

    Component.onDestruction:
    {

    }

    onNotePressed: soundPlayer.onNotePressed(octave, name);
    onDisplayNonLabeledNoteAsWrong: strings[d.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsWrong(d.currentNonlabeledNoteFretIndex);
    onDisplayNonLabeledNoteAsRight: strings[d.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsRight(d.currentNonlabeledNoteFretIndex);

    Rectangle {
        id:fretRect

        anchors.fill: parent
        color:parent.backgroundColor
        border.width: 0

        Canvas {
            id: fredboardCanvas
            anchors.fill: parent
            antialiasing: true

            onPaint:FretboardJs.drawFretboard(fredboardCanvas)
            onScaleChanged:requestPaint();

            Component.onCompleted:{
                FretboardJs.calculateFretDistances();
                FretboardJs.createStrings(stringNumber, fretRect);
            }

            Connections
            {
                target:fretBoardItem
                onFretsNumberChanged:{
                    FretboardJs.calculateFretDistances();
                    FretboardJs.createStrings(stringNumber, fretRect)
                    fredboardCanvas.requestPaint();
                }
                onShowNotesLabelsChanged:
                {
                    FretboardJs.setNotesLabelsVisible(!trainingMode && showNotesLabels)
                }
            }
        }
    }
}

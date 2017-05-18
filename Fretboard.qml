import QtQuick 2.0
import QtQuick.Controls 1.4


import "Content/Scripts/Fretboard.js" as FretboardJs
Item {
    id: fretBoardItem

    property color backgroundColor:"#D2691E"
    property color fretMarkerColor: "#ffffff"
    property int activeFretsNumber:22
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
        id: fretBoard

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
                fretBoard.currentNonLabeledNoteStringIndex = stringPosition;
                fretBoard.currentNonlabeledNoteFretIndex = fretPosition
                console.debug("Note to display nonlabeled", fretBoard.currentNonLabeledNoteStringIndex, fretBoard.currentNonlabeledNoteFretIndex);
                var displayedNoteName = strings[fretBoard.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNote(fretBoard.currentNonlabeledNoteFretIndex);
                nonlabeledNoteDisplayed(displayedNoteName);
            }
        }
    }

    Component.onDestruction:
    {

    }

    onNotePressed: soundPlayer.onNotePressed(octave, name);
    onDisplayNonLabeledNoteAsWrong: strings[fretBoard.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsWrong(fretBoard.currentNonlabeledNoteFretIndex);
    onDisplayNonLabeledNoteAsRight: strings[fretBoard.currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsRight(fretBoard.currentNonlabeledNoteFretIndex);

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
                FretboardJs.createStrings("qrc:/GuitarString.qml", stringNumber, fretRect);
            }

            Connections
            {
                target:fretBoardItem
                onActiveFretsNumberChanged:{
                    FretboardJs.calculateFretDistances();
                    FretboardJs.createStrings("qrc:/GuitarString.qml", stringNumber, fretRect)
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

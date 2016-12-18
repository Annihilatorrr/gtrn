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
    property var absoluteFretDistances:[]
    property var strings:[]
    property var tuning:[]
    property int currentNonLabeledNoteStringIndex
    property int currentNonlabeledNoteFretIndex

    signal notePressed(int octave, string name)
    signal nonlabeledNoteDisplayed(var noteName)
    signal nonLabeledDisplayingStopped();

    Connections{
        target:noteTrainer

        onDisplayNonLabeledNote:
        {
            if (trainingMode)
            {
                currentNonLabeledNoteStringIndex = stringPosition;
                currentNonlabeledNoteFretIndex = fretPosition
                console.debug("Note to display nonlabeled", currentNonLabeledNoteStringIndex, currentNonlabeledNoteFretIndex);
                var displayedNoteName = strings[currentNonLabeledNoteStringIndex - 1].displayNonLabeledNote(currentNonlabeledNoteFretIndex);
                nonlabeledNoteDisplayed(displayedNoteName);
            }
        }
    }

    onNotePressed:
    {
        soundPlayer.onNotePressed(octave, name);
    }

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

    function displayNonLabeledNoteAsWrong()
    {
        strings[currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsWrong(currentNonlabeledNoteFretIndex);
    }

    function displayNonLabeledNoteAsRight()
    {
        strings[currentNonLabeledNoteStringIndex - 1].displayNonLabeledNoteAsRight(currentNonlabeledNoteFretIndex);
    }
}

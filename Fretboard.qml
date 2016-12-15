import QtQuick 2.0
import QtQuick.Controls 1.4


import "Content/Scripts/Fretboard.js" as FretboardJs
Item {
    id: fretBoardItem
    property color backgroundColor:"#D2691E"
    property color fretMarkerColor: "#ffffff"

    property int fretsNumber:22
    property var tuning:[]
    property int stringNumber:tuning.length
    property int fretThickness:3

    property bool isMuted:false
    property bool showNotesLabels:true
    property bool trainingMode:false
    property var absoluteFretDistances:[]
    property var strings:[]

    signal notePressed(int octave, string name)
    function onDisplayNonLabeledNote(octave, name){
        console.debug("Note to display nonlabeled", name, octave);
    }

    Connections{
        target:noteTrainer
        onCorrectNoteDetected:
        {
            console.debug("Correct note", name, octave);
        }
    }

    onNotePressed:
    {
        soundPlayer.onNotePressed(octave, name);
        if (trainingMode)
        {
            noteTrainer.onNotePlayed(octave, name);
        }
    }

    Rectangle {
        id:fretRect
        anchors.fill: parent
        color:parent.backgroundColor
        border.width: 0

        Canvas {
            id: fredboardCanvas
            Component.onCompleted:{
                FretboardJs.calculateFretDistances();
                FretboardJs.createStrings(stringNumber, fretRect);
            }

            anchors.fill: parent
            antialiasing: true
            onScaleChanged:requestPaint();

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

            onPaint:FretboardJs.drawFretboard(fredboardCanvas)
        }
    }
}

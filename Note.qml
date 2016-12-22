import QtQuick 2.7
import QtQuick.Controls 2.0

import "Content/Scripts/Note.js" as NoteJs
import  "./Animations"

Item {
    id:noteItem

    QtObject {
            id: d
            readonly property int normalVisibleState:0
            readonly property int normalInvisibleState:1
            readonly property int nonlabeledState:2
            readonly property int rightState:3
            readonly property int wrongState:4
        }


    property color wrongNoteBackgroundColor:"red"
    property color rightNoteBackgroundColor:"green"
    property int octave:0
    property string name:""
    property int normalLabelRadius:height/2
    property color normalLabelBackgroundColor
    property color normalLabelBorderColor
    property color normalLabelTextColor
    property bool canAskForNewNote:false
    property int displayingState:d.normalVisibleState

    signal notePressed(int octave, string name)
    signal nonLabeledDisplayingStopped();
    signal displayNonLabeled();
    signal showLabels(bool isVisible);
    signal displayNonLabeledNoteAsWrong();
    signal displayNonLabeledNoteAsRight();

    onDisplayNonLabeled:NoteJs.displayNonLabeled();
    onShowLabels:NoteJs.showLabels(isVisible)
    onDisplayNonLabeledNoteAsWrong:NoteJs.displayNonLabeledNoteAsWrong();
    onDisplayNonLabeledNoteAsRight:NoteJs.displayNonLabeledNoteAsRight();

    property var normalNoteClickedAnimation:NormalNoteClickedAnimation
    {
        loops:1
        opacityUpFrom:displayingState === d.normalVisibleState ? 1.0: 0
        opacityUpTo:displayingState === d.normalVisibleState ? 0: 1.0
        opacityDownFrom:displayingState === d.normalVisibleState ? 0: 1.0
        opacityDownTo:displayingState === d.normalVisibleState ? 1.0: 0
        upDuration:300
        downDuration:300
        pauseDuration:500
        running:false
        animationTarget:noteItem
    }

    property var trainingModeNodeAnimation:TrainingModeNoteAnimation
    {
        radius:normalLabelRadius
        running:false
        animationTarget:noteItem
        onStarted: {console.debug("WrongRight animation started")}
        onStopped:
        {
            console.debug("WrongRight animation stopped");
            noteItem.nonLabeledDisplayingStopped();
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color:"transparent"
        Canvas{
            id:noteCanvas
            anchors.fill: parent
            antialiasing:true
            onPaint: NoteJs.drawLabel(noteCanvas);
        }
        MouseArea{
            anchors.fill: parent
            onPressed: {
                noteItem.notePressed(noteItem.octave, noteItem.name)
                normalNoteClickedAnimation.running = true;
            }
        }
    }

    onDisplayingStateChanged: noteCanvas.requestPaint()
    onOpacityChanged:noteCanvas.requestPaint()
    onNormalLabelRadiusChanged:noteCanvas.requestPaint()
}


import QtQuick 2.0
import QtQuick.Controls 2.0

import "Content/Scripts/Note.js" as NoteJs
Item {
    QtObject {
            id: d
            readonly property int normalVisibleState:0
            readonly property int normalInvisibleState:1
            readonly property int nonlabeledState:2
            readonly property int rightState:3
            readonly property int wrongState:4
        }
    id:noteItem

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

    SequentialAnimation {
        id: sequentialNormalNoteAnimation
        loops: 1
        running: false

        NumberAnimation {
                id: opacityUpAnimation
                target: noteItem
                property: "opacity"
                from: displayingState === d.normalVisibleState ? 1.0: 0
                to: displayingState === d.normalVisibleState ? 0: 1.0
                duration: 300
                easing {type: Easing.OutCubic}
           }
        PauseAnimation { duration: 2000 }
        NumberAnimation {
                id:opacityDownAnimation
                target: noteItem
                property: "opacity"
                to: displayingState === d.normalVisibleState ? 1.0: 0
                from: displayingState === d.normalVisibleState ? 0: 1.0
                duration: 300
                easing {type: Easing.OutCubic}
           }
    }

    SequentialAnimation {
        id: sequentialRightWrongNoteAnimation
        loops: 1
        running: false

        NumberAnimation {
            id: radiusUpAnimation
            target: noteItem
            property: "normalLabelRadius"
            from: normalLabelRadius
            to: normalLabelRadius + 1
            duration: 30
            easing {type: Easing.OutCubic}
        }
        NumberAnimation {
            id:radiusDownAnimation
            target: noteItem
            property: "normalLabelRadius"
            to: normalLabelRadius
            from: normalLabelRadius + 1
            duration: 500
            easing {type: Easing.OutCubic}
        }
        PauseAnimation { duration: 2000 }
        NumberAnimation {
            id:wrongNotePpacityDownAnimation
            target: noteItem
            property: "opacity"
            to: 0
            from: 1
            duration: 1000
            easing {type: Easing.OutCubic}
       }

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
                sequentialNormalNoteAnimation.running = true;
            }
        }
    }

    onDisplayingStateChanged: noteCanvas.requestPaint()

    onOpacityChanged:noteCanvas.requestPaint()
    onNormalLabelRadiusChanged:noteCanvas.requestPaint()

    function displayNonLabeled()
    {
        displayingState = d.nonlabeledState;
        noteItem.opacity = 1.0;
        noteCanvas.requestPaint();
    }

    function setVisible(isVisible)
    {
        displayingState = isVisible ? d.normalVisibleState : d.normalInvisibleState;
        noteItem.opacity = isVisible ? 1.0:0.0;
    }

    function displayNonLabeledNoteAsWrong()
    {
       displayingState = d.wrongState;
       sequentialRightWrongNoteAnimation.running = true
    }

    function displayNonLabeledNoteAsRight()
    {
        displayingState = d.rightState;
        sequentialRightWrongNoteAnimation.running = true
    }
}


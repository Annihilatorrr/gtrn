import QtQuick 2.0
import QtQuick.Controls 2.0

import "Content/Scripts/Note.js" as NoteJs
Item {
    QtObject {
            id: d
            readonly property int normalState:0
            readonly property int nonlabeledState:1
            readonly property int correctState:2
            readonly property int wrongState:3
        }
    id:noteItem
    property color backgroundColor:"blue"
    property int octave:0
    property string name:""
    property int normalLabelRadius
    property color normalLabelBackgroundColor
    property color normalLabelBorderColor
    property color normalLabelTextColor
    property bool showNotesLabels:true
    property int displayingState:d.normalState
    property bool previousNoteVisibility:false

    signal notePressed(int octave, string name)

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
                previousNoteVisibility = showNotesLabels
                showNotesLabels = true;
                noteCanvas.requestPaint()
                visibilityTimer.start()
            }
        }

        Timer {
                id:visibilityTimer
                interval: 3000; running: false; repeat: false;
                onTriggered:
                {
                    showNotesLabels = previousNoteVisibility;
                    noteCanvas.requestPaint()
                }
            }

    }
    onShowNotesLabelsChanged: noteCanvas.requestPaint()

    function displayNonLabeled()
    {
        displayingState = d.nonlabeledState;
        noteCanvas.requestPaint();
    }


}


import QtQuick 2.0
import QtQuick.Controls 2.0

import "Content/Scripts/Note.js" as NoteJs
Item {
    id:noteItem
    property color backgroundColor:"blue"
    property int octave:0
    property string name:""
    property int labelRadius
    property color labelBackgroundColor
    property color labelBorderColor
    property color labelTextColor
    property bool showNotesLabels:true

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
                //noteCanvas.requestPaint()
            }
        }
    }
    onShowNotesLabelsChanged: noteCanvas.requestPaint()
}


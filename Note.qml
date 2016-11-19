import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id:noteItem
    property color backgroundColor:"white"
    property int octave:-1
    property string name:""
    signal notePressed(int octave, string name)
    Rectangle{
        anchors.fill: parent
        color:parent.backgroundColor
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text:name
        }

        MouseArea{
            anchors.fill: parent
            onPressed: noteItem.notePressed(noteItem.octave, noteItem.name)
        }
    }
}


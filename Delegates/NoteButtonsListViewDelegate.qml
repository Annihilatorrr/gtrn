import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id:noteButtonsItemdelegateId
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: 80
    height:50

    signal clicked(var text);

    Button {
        anchors.fill: parent
        text: modelData
        onClicked: {
            noteButtonsItemdelegateId.clicked(text);
        }
        style: ButtonStyle {
            background: Rectangle {
                border.width:control.activeFocus ? 5 : 3
                radius:6
                border.color: control.pressed ? "#002e4d" : "#006bb3"
                anchors.fill: parent
                color:  control.pressed ? "#006bb3" :"#0099ff"
            }
        }
    }
}

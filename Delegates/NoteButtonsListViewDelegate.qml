import QtQuick 2.7
import QtQuick.Controls 1.4

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
//            if(text === expectedNoteName)
//            {
//                fretBoard.displayNonLabeledNoteAsRight()
//                console.debug('right')
//            }
//            else
//            {
//                fretBoard.displayNonLabeledNoteAsWrong()
//                console.debug('wrong')
//            }
        }
    }
}

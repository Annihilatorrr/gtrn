import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "Content/Scripts/FretboardPage.js" as FretboardPageJs
import "Content/Scripts/common.js" as CommonJs

Item
{
    id:fretboardPage

    property bool isMuted:false
    property bool showNotesLabels:true
    property int fretsNumber:22
    property var notesToSelect:[]
    property var expectedNoteName
    Column
    {
        spacing: 2
        anchors.fill: parent
        Rectangle
        {
            width:parent.width
            height: 160

            color:"white"
            Fretboard
            {
                id:fb
                objectName:"FretboardObject"
                x:5
                y:5
                width:1100
                trainingMode: true
                height:150
                backgroundColor: "#2B1B17"
                fretsNumber:22
                tuning:["E4", "B3", "G3", "D3", "A2", "E2"]

                onNonlabeledNoteDisplayed:
                {
                    expectedNoteName = noteName;
                    console.debug("expectedNoteName", expectedNoteName);
                    notesToSelect = CommonJs.getRandomNotesArrayWithOneDefined(noteName, 5);
                    console.debug("Random array:", notesToSelect);

                }
            }
        }
        ListView {
            id: trainingModeListView
            height: 30
            width: 430
            interactive: false
            anchors.horizontalCenter:parent.horizontalCenter
            orientation: ListView.Horizontal
            spacing:15
            delegate: Item {
                id: item
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 80
                height:50
                Button {
                    anchors.fill: parent
                    text: modelData

                    onClicked: {

                        if(text === expectedNoteName)
                        {
                            console.debug('Correct')
                        }
                        else
                        {
                            console.debug('Incorrect')
                        }
                        noteTrainer.onGetNextNote();
                    }
                }
            }

            model: notesToSelect
//                ListModel {
//                id: listModel
//                ListElement {
//                    noteName: notesToSelect[0]
//                }

//                ListElement {
//                    noteName: notesToSelect[1]
//                }
//                ListElement {
//                    noteName: ""
//                }
//                ListElement {
//                    noteName: ""
//                }
//                ListElement {
//                    noteName: ""
//                }
//            }
        }
        Rectangle
        {
            color: "blue"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
    Component.onCompleted:
    {
        FretboardPageJs.readCurrentSettings();
        noteTrainer.onStartTraining(fb.stringNumber, fb.fretsNumber);
    }

    Connections
    {
        target: fretboardPage
        onIsMutedChanged:
        {
            fb.isMuted = isMuted;
        }
        onShowNotesLabelsChanged:
        {
            fb.showNotesLabels = showNotesLabels;
        }
        onFretsNumberChanged:
        {
            fb.fretsNumber = fretsNumber;
        }
    }

    function updateSettings()
    {
        FretboardPageJs.readCurrentSettings();
    }
}

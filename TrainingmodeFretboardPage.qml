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
                id:fretBoard
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
                    console.debug("Expected note name", expectedNoteName);
                    notesToSelect = CommonJs.getRandomNotesArrayWithOneDefined(expectedNoteName, 5);
                    console.debug("Array of random notes:", notesToSelect);
                }

                onNonLabeledDisplayingStopped:
                {
                    noteTrainer.onGetNextNote();
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
                            fretBoard.displayNonLabeledNoteAsRight()
                            console.debug('right')
                        }
                        else
                        {
                            fretBoard.displayNonLabeledNoteAsWrong()
                            console.debug('wrong')
                        }
                    }
                }
            }

            model: notesToSelect
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
        noteTrainer.onStartTraining(fretBoard.stringNumber, fretBoard.fretsNumber);
    }

    Connections
    {
        target: fretboardPage
        onIsMutedChanged:
        {
            fretBoard.isMuted = isMuted;
        }
        onShowNotesLabelsChanged:
        {
            fretBoard.showNotesLabels = showNotesLabels;
        }
        onFretsNumberChanged:
        {
            fretBoard.fretsNumber = fretsNumber;
        }
    }

    function updateSettings()
    {
        FretboardPageJs.readCurrentSettings();
        noteTrainer.onUpdateSettings(fretBoard.stringNumber, fretBoard.fretsNumber)
    }
}

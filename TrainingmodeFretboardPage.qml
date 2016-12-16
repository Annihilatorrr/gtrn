import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "Content/Scripts/FretboardPage.js" as FretboardPageJs

Item
{
    id:fretboardPage

    property bool isMuted:false
    property bool showNotesLabels:true
    property int fretsNumber:22

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
            }
        }
        ListView {
            id: listView1
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
                    text: noteName

                    onClicked: {
                        textIndex.text = index
                    }
                }
            }

            model: ListModel {
                id: listModel
                ListElement {
                    noteName: ""
                }

                ListElement {
                    noteName: ""
                }
                ListElement {
                    noteName: ""
                }
                ListElement {
                    noteName: ""
                }
                ListElement {
                    noteName: ""
                }
            }
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
        noteTrainer.onStartTraining();
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

import QtQuick 2.0
import QtQuick.Layouts 1.0

import "Content/Scripts/FretboardPage.js" as FretboardPageJs

Item
{
    id:fretboardPage

    property bool isMuted:false
    property bool showNotesLabels:true
    property int fretsNumber:22

    ColumnLayout
    {
        spacing: 2
        anchors.fill: parent
        Rectangle
        {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 160

            color:"#2F4F4F"
            Fretboard
            {
                id:fb
                objectName:"FretboardObject"
                x:5
                y:5
                width:1100
                height:150
                backgroundColor: "#2B1B17"
                fretsNumber:22
                tuning:["E4", "B3", "G3", "D3", "A2", "E2"]
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

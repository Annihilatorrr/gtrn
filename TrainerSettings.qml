import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4

import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.0

import "Content/Scripts/TrainerSettings.js" as TrainerSettingsJs

Window {
    width: 320
    height: 240
    //color: "#215400"
    title: "Settings"
    id:settingsWindowId

    property var fretSettings:{
        "isMuted":false
    }

    flags: Qt.Popup | Qt.Tool

    GridLayout {
        columns: 8
        rows:6
        rowSpacing:2
        columnSpacing:2
        anchors.fill: parent
        anchors.margins: 10
        Rectangle{
            Layout.column: 0
            Layout.row:0
            Layout.columnSpan:2
            Layout.preferredHeight: 20
            Layout.fillWidth: true
            color:"red"
            CheckBox {
                id:isMutedId
                text: "Mute"
            }
        }
        Rectangle {
            Layout.column: 2
            Layout.columnSpan: 6
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            color:"#ff8000"
        }
        Rectangle {
            Layout.column: 0
            Layout.row:1
            Layout.columnSpan:2
            color: "blue"
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            CheckBox {
                id:showNotesLabelsId
                text: "Show labels"
            }
        }
        Rectangle {
            Layout.column: 0
            Layout.row:2
            Layout.columnSpan: 4
            color: "blue"
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            Label {

                wrapMode: Label.Wrap
                text:"Frets to display (1-24)"
            }
        }
        Rectangle {
            Layout.column: 4
            Layout.row:2
            Layout.columnSpan: 1
            color: "blue"
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            TextField {
                id: fretsNumberId
                width:25
                validator: IntValidator {bottom: 1; top: 24;}
            }
        }
        Rectangle {
            Layout.column: 0
            Layout.row: 3
            Layout.columnSpan: 8
            Layout.fillWidth: true
            Layout.fillHeight: true
            color:"#ff8000"
        }

    }

    onClosing: {
        TrainerSettingsJs.writeCurrentSettings();
    }

    Component.onCompleted: {
        TrainerSettingsJs.readCurrentSettings();
    }
}

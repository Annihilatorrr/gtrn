import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4

import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.0

import "Content/Scripts/TrainerSettings.js" as TrainerSettingsJs

import  './Styles'

Window {
    width: 320
    height: 240
    //color: "#215400"
    title: "Settings"
    id:settingsWindowId
    modality: Qt.ApplicationModal
    flags: Qt.Popup | Qt.Tool

    GridLayout {
        columns: 8
        rows:6
        rowSpacing:2
        columnSpacing:2
        anchors.fill: parent
        anchors.margins: 10

        CheckBox {
            Layout.column: 0
            Layout.row:0
            Layout.columnSpan:1
            Layout.preferredHeight: 20
            Layout.fillWidth: false
            id:isMutedId
            text: "Mute"
            style: CheckBoxWithRectangleStyle{}
        }

        Rectangle {
            Layout.column: 1
            Layout.row:0
            Layout.columnSpan: 7
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            color:"transparent"
        }

        CheckBox {
            id:showNotesLabelsId
            Layout.column: 0
            Layout.row:1
            Layout.columnSpan:2
            Layout.fillWidth: false
            Layout.preferredHeight: 20
            text: "Show labels"
            style: CheckBoxWithRectangleStyle{}
        }

        Rectangle {
            Layout.column: 2
            Layout.row:1
            Layout.columnSpan: 6
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            color:"transparent"
        }

        Label {
            Layout.column: 0
            Layout.row:2
            Layout.columnSpan: 3
            Layout.fillWidth: false
            Layout.preferredHeight: 15
            text:"Frets to display (1-24):"
        }

        Label {
            id: activeFretsNumberId
            Layout.preferredWidth:15
            Layout.fillWidth: false
            Layout.column: 3
            Layout.row:2
            Layout.columnSpan: 1
            Layout.preferredHeight: 15
            text: Math.floor(activeFretsNumberSliderId.value)
        }

        Slider {
            id: activeFretsNumberSliderId
            property real activeFretsNumber: value
            Layout.fillWidth: true
            Layout.preferredHeight: 35
            Layout.row:2
            Layout.column: 4
            Layout.columnSpan: 4
            value: 22
            minimumValue: 1
            maximumValue: 24
         }

        Rectangle {
            Layout.column: 0
            Layout.row: 3
            Layout.columnSpan: 8
            Layout.fillWidth: true
            Layout.fillHeight: true
            color:"transparent"
        }
    }

    onClosing: {
        TrainerSettingsJs.writeCurrentSettings();
    }

    Component.onCompleted: {
        TrainerSettingsJs.readCurrentSettings();
    }
}

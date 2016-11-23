import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4

import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.0

import oleumsoft.com.utils 1.0

Window {
    width: 320
    height: 240
    //color: "#215400"
    title: "Settings"
    id:settingsWindowId

    property var fretSettings:{
        "isMuted":false
    }

    //flags: Qt.Window | Qt.WindowFullscreenButtonHint

    SettingsHelper {
        id: settingsHelperId
    }

    GridLayout {
        columns: 2
        rows:6
        anchors.fill: parent
        Rectangle{
            Layout.column: 0
            Layout.row:0
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            color:"red"
            CheckBox {
                id:isMutedId
                text: "Mute"
            }
        }
        Rectangle {
            Layout.column: 0
            Layout.row:1
            color: "blue"
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            CheckBox {
                id:showNotesLabelsId
                text: "Show labels"
            }
        }
    }

    onClosing: {
        settingsHelperId.setValue("isMuted", isMutedId.checked)
        fretSettings.isMuted = isMutedId.checked;

        settingsHelperId.setValue("showNotesLabels", showNotesLabelsId.checked)
        fretSettings.showNotesLabels = showNotesLabelsId.checked;
    }

    Component.onCompleted: {
        fretSettings.isMuted = settingsHelperId.getBoolValue("isMuted", settingsWindowId.isMuted);
        isMutedId.checked = fretSettings.isMuted;

        fretSettings.showNotesLabels = settingsHelperId.getBoolValue("showNotesLabels", settingsWindowId.showNotesLabels);
        showNotesLabelsId.checked = fretSettings.showNotesLabels;
    }
}

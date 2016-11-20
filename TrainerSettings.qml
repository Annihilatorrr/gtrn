import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import org.example.SettingsProvider 1.0

Window {
    width: 320
    height: 240
    color: "#215400"
    title: "Settings"
    id:settingsWindowId
    flags: Qt.Window | Qt.WindowFullscreenButtonHint

    SettingsProvider {
            id: filereader
        }
    Component.onCompleted: {
        var d = filereader.read("D:\\trainer.txt")
        var obj = JSON.parser(json_string);
        var w = 0;
    }

    ColumnLayout {
        CheckBox {
            id:isMutedId
            text: "Mute"
            checked: settings.isMuted
            Layout.alignment: Qt.AlignRight
        }
    }
    onClosing: {
        var checked = isMutedId.checked;
        settings.isMuted = isMutedId.checked;
    }

    Settings {
          id: settings
          property bool isMuted
    }

}

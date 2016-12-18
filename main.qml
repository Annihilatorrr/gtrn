import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "Content/Scripts/common.js" as CommonJs
import "Content/Scripts/main.js" as MainJs

ApplicationWindow
{
    id:root
    visible: true
    width: 1124
    height: 250
    title: qsTr("Guitar trainer")

    property variant settingsWindow
    property bool isMuted:false
    property bool showNotesLabels:true
    property int fretsNumber:22

    property alias menuPage:menuPage

    toolBar:ToolBar {
        height:50
        RowLayout {
            anchors.fill: parent
            ToolButton {
                height:48
                width:48
                iconSource: "/Content/Icons/toolbar_settings.png"
                onClicked:{
                    settingsWindow.visible === false
                           ? settingsWindow.show()
                           : settingsWindow.requestActivate();
                }
            }
            ToolButton {
                iconSource: "open.png"
            }
            ToolButton {
                iconSource: "save-as.png"
            }
            Item { Layout.fillWidth: true }
            CheckBox {
                text: "Enabled"
                checked: true
                Layout.alignment: Qt.AlignRight
            }
                }
            style: ToolBarStyle {
                padding {
                    left: 18
                    right: 8
                    top: 3
                    bottom: 3
                }
                background: Rectangle {
                   anchors.fill: parent
                    border.color: "#aaf999"
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: "#fff" }
                        GradientStop { position: 1 ; color: "#eee" }
                    }
                }
        }
    }
    MenuPage
    {
        anchors.fill: parent
        id: menuPage
    }

    Component.onCompleted:
    {
        settingsWindow = CommonJs.createObjectFromQmlFile("qrc:/TrainerSettings.qml", {}, null);
        settingsWindow.closing.connect(menuPage.updatePagesSettings);
        //MainJs.readCurrentSettings();
    }
}

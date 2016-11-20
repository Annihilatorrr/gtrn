import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow
{
    id:root
    visible: true
    width: 1124
    height: 600
    title: qsTr("Guitar trainer")
    property variant settingsWindow
    toolBar:ToolBar {
        height:50
        RowLayout {
            anchors.fill: parent
            ToolButton {
                height:48
                width:48
                iconSource: "/Content/Icons/toolbar_settings.png"
                onClicked:{
                    if (settingsWindow === undefined)
                    {
                        var component = Qt.createComponent("TrainerSettings.qml");
                        if (component.status == Component.Ready)
                        {
                            settingsWindow = component.createObject(root);
                        }
                        else
                        {
                            console.log("Error while opening the settings window: ", component.errorString())
                        }
                    }
                    settingsWindow.show();

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
                left: 8
                right: 8
                top: 3
                bottom: 3
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                border.color: "#999"
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#fff" }
                    GradientStop { position: 1 ; color: "#eee" }
                }
            }
        }
    }
    ColumnLayout{
        spacing: 2
        anchors.fill: parent
        Rectangle
        {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 160

            color:"red"
            Fretboard {
                id:fb
                objectName:"FretboardObject"
                x:5
                y:5
                width:1100
                height:150
                backgroundColor: "#2B1B17"
                fretNumber:22
                tuning:["E4", "B3", "G3", "D3", "A2", "E2"]
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Column {
                Slider {id: lineWidthCtrl ; minimumValue : 1 ; maximumValue : 10 ; value : 2 }
                Slider {id: scaleCtrl ; minimumValue : 0.1 ; maximumValue : 10 ; value : 1 }
                Slider {id: rotateCtrl ; minimumValue : 0 ; maximumValue : Math.PI*2 ; value : 0}
            }
        }

        Rectangle {
            color: "blue"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}

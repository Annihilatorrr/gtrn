import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
ApplicationWindow
{
    id:root
    visible: true
    width: 900
    height: 600
    title: qsTr("Hello World")
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
                x:5
                y:5
                width:880
                height:150
                backgroundColor: "#4d1a00"
                fretNumber:4
                stringNumber:6
                tuning:["E", "B", "G", "D", "A", "E"]
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

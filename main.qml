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
    flags: Qt.MSWindowsFixedSizeDialogHint

    property variant settingsWindow
    property bool isMuted:false
    property bool showNotesLabels:true
    property int activeFretsNumber:22

    property alias menuPage:menuPage

    toolBar:ToolBar {

        height:48
        RowLayout {
            anchors.fill: parent
            ToolButton {
                Image {
                    source: "qrc:/Content/Icons/toolbar_settings.png"
                    anchors.fill: parent
                }

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
            MouseArea{
                property variant clickPos: "1,1"

                anchors.right:parent.right
                anchors.left:parent.left
                anchors.margins: {left:40}
                anchors.top:parent.top
                anchors.bottom: parent.bottom

                onPressed: {
                    clickPos  = Qt.point(mouse.x,mouse.y)
                }

                onPositionChanged: {
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    root.x += delta.x;
                    root.y += delta.y;
                }
            }

        }
        style: ToolBarStyle {
            padding {
                left: 10
                right: 10
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

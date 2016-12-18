import QtQuick 2.0
import QtQuick.Controls 1.4
Item {
    id: menuPage

    width: parent.width
    height: parent.height

    StackView {
        id: stackView
        width: parent.width
        height: parent.height

        property alias startItem:initialItem
        anchors.fill: parent

        // Implements back key navigation
        focus: true
        Keys.onReleased: {
            console.debug("Event key: ", event.key, "Qt.Key_Back: ", Qt.Key_Back)
            if (event.key === Qt.Key_Left && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }
        }
        initialItem: Item {
            width: parent.width
            height: parent.height
            id:initialItem
            property alias itemsGrid:itemsGrid

            GridView {
                id:itemsGrid
                interactive: false
                focus: true
                model: pageModel
                anchors.fill: parent

                delegate: MainMenuItemDelegate {
                    text: title
                    onClicked: stackView.push(Qt.resolvedUrl(page))
                }
            }
        }
    }

    ListModel {
        id: pageModel

        ListElement {
            title: "Free mode"
            page: "/FreemodeFretboardPage.qml"
        }

        ListElement {
            title: "Training mode"
            page: "/TrainingmodeFretboardPage.qml"
        }
    }

    function updatePagesSettings()
    {
        var itemCount = menuPage.stackView.depth;
        for (var i = 1; i < itemCount; i++)
        {
            menuPage.stackView.get(i).updateSettings();
        }

    }
}

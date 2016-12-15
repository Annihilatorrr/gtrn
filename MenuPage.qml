import QtQuick 2.0
import QtQuick.Controls 1.4
Item {
    id: menuPage
    property alias stackView:stackView
    StackView {
            width: 300; height: 200
            id: stackView
            property alias startItem:initialItem
            anchors.fill: parent

            // Implements back key navigation
            focus: true
            Keys.onReleased: {
                console.log("Event key: ", event.key, "Qt.Key_Back: ", Qt.Key_Back)
                if (event.key === Qt.Key_Back && stackView.depth > 1) {
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
        ListElement {
            title: "FretBoard2"
            page: "/FretboardPage.qml"
        }
    }

    function updatePagesSettings()
    {
        //var svVpunt = menuPage.stackView.startItem.itemsGrid.count;
        var itemCount = menuPage.stackView.depth;
        for (var i = 1; i < itemCount; i++)
        {
            menuPage.stackView.get(i).updateSettings();
        }

    }
}

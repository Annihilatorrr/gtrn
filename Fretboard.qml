import QtQuick 2.0
import QtQuick.Controls 1.4
import oleumsoft.com.utils 1.0

import "Content/Scripts/Fretboard.js" as FretboardJs
Item {
    id: fretItem
    property color backgroundColor:"white"
    property int fretsNumber:22
    property int stringNumber:tuning.length
    signal notePressed(int octave, string name)
    property variant tuning:[]
    property bool isMuted:false
    property bool showNotesLabels:true
    property var fretDistances:[]
    property var strings:[]

    property color fillStyle: "#ffffff" // yellow
    property color strokeStyle: "#ff00ff"

    //onDisplayNonLabeledNote:{}
    function onDisplayNonLabeledNote(octave, name){
        console.log("Note to display nonlabeled", name, octave);
    }

    Connections{
        target:noteController
        onDisplayNonLabeledNote:
        {
            console.log("Note to display nonlabeled", note, octave);
        }
    }

    Rectangle {
        id:fretRect
        anchors.fill: parent
        color:parent.backgroundColor
        border.width: 0

        Canvas {
            id: fredboardCanvas
            Component.onCompleted:{
                FretboardJs.calculateFretDistances();
                FretboardJs.createStrings(stringNumber, fretRect);
            }

            anchors.fill: parent

            antialiasing: true

            onScaleChanged:requestPaint();

            Connections
            {
                target:fretItem
                onFretsNumberChanged:{
                    fredboardCanvas.requestPaint();
                    FretboardJs.createStrings(stringNumber, fretRect)
                }
                onShowNotesLabelsChanged:
                {
                    for (var i = 0; i < stringNumber; ++i)
                    {
                        strings[i].showNotesLabels = showNotesLabels;
                        console.log("Setting for string #", i, " showNotesLabels = ", showNotesLabels)
                    }
                }
            }

            onPaint:FretboardJs.drawFretboard(fredboardCanvas)
        }
    }
}

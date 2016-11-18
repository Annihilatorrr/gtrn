import QtQuick 2.0

Item {
    id:stringItem
    property variant fretDistances:[]
    property string initialNote:""
    property int initialNoteOctave:0
    property int activeAreaHeight
    property int fretThickness
    signal notePressed(int octave, string name)
    property variant notesNames:["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", ]
//    Rectangle{
//        width:parent.width
//        height:parent.height
//        color: "green"
//    }
    function onNotePressed()
    {
        sequentialStringWidthAnimation.running = true;
    }

    SequentialAnimation {
        loops: 40
        running: false

        id: sequentialStringWidthAnimation
        NumberAnimation {
                id: stringWidthUpAnimation
                target: guitarStringCanvas
                properties: "stringWidth"
                from: 3
                to: 4
                duration: 70
                easing {type: Easing.OutCubic}
           }
        // Then pause for 500ms
        NumberAnimation {
                id:stringWidthDownAnimation
                target: guitarStringCanvas
                properties: "stringWidth"
                to: 3
                from: 4
                duration: 70
                easing {type: Easing.OutCubic}
           }


    }

    Canvas {
        id:guitarStringCanvas
        property int stringWidth:3
        width: parent.width
        height: parent.height
        onStringWidthChanged: requestPaint()
        onPaint: {
            // Get drawing context
            var context = getContext("2d");


            var gradient = context.createLinearGradient(0,0, 0,height )
           gradient.addColorStop(0, "#000000")
            gradient.addColorStop(0.45, "#C5CECE")
           gradient.addColorStop(0.5, "white")
           gradient.addColorStop(0.55, "#C5CECE")
            gradient.addColorStop(1, "#000000")
            // Fill inside with blue, leaving 10 pixel border
            // context.beginPath();
            //
            // context.fillStyle = gradient
            //            context.fillRect(0, 0, width, height);
            //            context.fill();
            context.clearRect(0, 0, width, height);
            // Draw a line
            context.beginPath();
            context.lineWidth = stringWidth;
            context.moveTo(0, height/2);
            context.strokeStyle = gradient
            context.lineTo(width, height/2);
            context.stroke();


        }
    }
    function createNotes(height, fretThickness)
    {
        var notesNumber = fretDistances.length
        var octaveCounter = initialNoteOctave;
        for (var i = 0; i < notesNumber - 1; ++i)
        {
            var component = Qt.createComponent("Note.qml");

            var settings = {
                "x": fretDistances[i] + fretThickness/2,
                "y": 0,
                "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
                "height": activeAreaHeight,
                "backgroundColor":"transparent",
                "octave":5
            };
            var note = component.createObject(stringItem,settings);
            note.notePressed.connect(notePressed);
            note.notePressed.connect(onNotePressed);
        }
    }

    Component.onCompleted:{
        createNotes(activeAreaHeight, fretThickness);
    }
}

import QtQuick 2.0

Item {
    id:stringItem
    property variant fretDistances:[]
    property string initialNote:"E"
    property int initialNoteOctave:1
    property int activeAreaHeight
    property int fretThickness
    signal notePressed(int octave, string name)
    property variant notesNames:["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", ]

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
                from: 2
                to: 3
                duration: 70
                easing {type: Easing.OutCubic}
           }
        // Then pause for 500ms
        NumberAnimation {
                id:stringWidthDownAnimation
                target: guitarStringCanvas
                properties: "stringWidth"
                to: 2
                from: 3
                duration: 70
                easing {type: Easing.OutCubic}
           }
    }

    Canvas {
        id:guitarStringCanvas
        property int stringWidth:2
        width: parent.width
        height: parent.height
        onStringWidthChanged: requestPaint()
        onPaint: {
            // Get drawing context
            var context = getContext("2d");
            context.clearRect(0, 0, width, height);
            context.strokeStyle = createGradientForString(context);

            // Draw a line
            context.beginPath();
            context.lineWidth = stringWidth;
            context.moveTo(0, height/2);
            context.lineTo(width, height/2);
            context.stroke();
        }
    }

    function createGradientForString(context)
    {
        var gradient = context.createLinearGradient(0,0, 0,height )
        context.clearRect(0, 0, width, height);
        gradient.addColorStop(0, "#000000");
        gradient.addColorStop(0.45, "#C5CECE");
        gradient.addColorStop(0.5, "white");
        gradient.addColorStop(0.55, "#C5CECE");
        gradient.addColorStop(1, "#000000");
        return gradient;
    }

    function createNotes(height, fretThickness)
    {
        var notesNumber = fretDistances.length
        var octaveCounter = stringItem.initialNoteOctave;
        var fd = fretDistances;
        for (var i = 0, initialNoteIndex = notesNames.indexOf(initialNote); i < notesNumber - 1 ; ++i, ++initialNoteIndex)
        {
            var component = Qt.createComponent("Note.qml");

            var settings = {
                "x": fretDistances[i] + fretThickness/2,
                "y": 0,
                "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
                "height": activeAreaHeight,
                "backgroundColor":"blue",
                "octave":octaveCounter,
                "name":notesNames[initialNoteIndex%12],
                "labelRadius":9,
                "labelBackgroundColor":'#FF0000',
                "labelBorderColor":'#C11B17',
                "labelTextColor":"#FFFFFF"
            };

            if (initialNoteIndex%12 == 0 && initialNoteIndex != 0)
            {
                ++octaveCounter;
            }

            var note = component.createObject(stringItem,settings);
            note.notePressed.connect(notePressed);
            note.notePressed.connect(onNotePressed);
        }
    }

    Component.onCompleted:{
        createNotes(activeAreaHeight, fretThickness);
    }
}

function drawString(canvas)
{
    var w = width;
    var g = height;
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
    context.strokeStyle = createGradientForString(context);

    // Draw a line
    context.beginPath();
    context.lineWidth = stringWidth;
    context.moveTo(0, height/2);
    context.lineTo(width, height/2);
    context.stroke();
}

function createGradientForString(context)
{
    var gradient = context.createLinearGradient(0,0, 0,height )
    context.clearRect(0, 0, width, height);

    gradient.addColorStop(0.4, "#333333");
    gradient.addColorStop(0.5, "white");
    gradient.addColorStop(0.6, "#333333");

    return gradient;
}


function onNotePressed()
{
   // sequentialStringWidthAnimation.running = true;
}

function createNotes(height, fretThickness)
{
    var notesNumber = fretDistances.length
    var octaveCounter = stringItem.initialNoteOctave;
    var fd = fretDistances;
    var l = notes.length;
    for (var i = 0, initialNoteIndex = notesNames.indexOf(initialNote); i < notesNumber - 1 ; ++i, ++initialNoteIndex)
    {
        var settings = {
            "x": fretDistances[i] + fretThickness/2,
            "y": 0,
            "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
            "height": activeAreaHeight,
            "backgroundColor":"blue",
            "octave":octaveCounter,
            "name":notesNames[initialNoteIndex%12],
            "labelRadius":10,
            "labelBackgroundColor":'#AAFFA500',
            "labelBorderColor":'#C11B17',
            "labelTextColor":"#FFFFFF"
        };

        if (initialNoteIndex%12 == 0 && initialNoteIndex != 0)
        {
            ++octaveCounter;
        }

        var component = Qt.createComponent("qrc:/Note.qml");
        notes[i] = component.createObject(stringItem,settings);
        notes[i].notePressed.connect(notePressed);
        notes[i].notePressed.connect(onNotePressed);
        notes[i].showNotesLabels = showNotesLabels;
    }
}

function clear(context)
{
    context.clearRect(0, 0, width, height);
}


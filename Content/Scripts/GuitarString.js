function drawString(canvas)
{
    var w = width;
    var g = height;
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
    context.strokeStyle = createGradientForString(context);

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
    var octaveCounter = stringItem.stringInitialNoteOctave;
    var fd = fretDistances;
    var l = notes.length;
    for (var i = 0, nameIndex = notesNames.indexOf(initialNote); i < notesNumber - 1 ; ++i, ++nameIndex)
    {
        var settings = {
            "x": fretDistances[i] + fretThickness/2,
            "y": 0,
            "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
            "height": activeAreaHeight,
            "backgroundColor":"blue",
            "octave":octaveCounter,
            "name":notesNames[nameIndex%12],
            "normalLabelRadius":10,
            "normalLabelBackgroundColor":'#AAFFA500',
            "normalLabelBorderColor":'#C11B17',
            "normalLabelTextColor":"#FFFFFF"
        };

        if (nameIndex%12 == 0 && nameIndex != 0)
        {
            ++octaveCounter;
        }

        var component = Qt.createComponent("qrc:/Note.qml");
        if( component.status !== Component.Ready )
        {
        if( component.status === Component.Error )
                console.debug("Error:"+ component.errorString() );
        }
        else
        {

            notes[i] = component.createObject(stringItem,settings);
            notes[i].notePressed.connect(notePressed);
            notes[i].nonLabeledDisplayingStopped.connect(nonLabeledDisplayingStopped);
            //notes[i].notePressed.connect(onNotePressed);
            notes[i].setVisible(showNotesLabels);
        }
    }
}

function clear(context)
{
    context.clearRect(0, 0, width, height);
}


function drawString(canvas)
{
    var w = width;
    var g = height;
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
    context.strokeStyle = createGradientForString(context);
    context.fillStyle = createGradientForOscillation(context);
    context.beginPath();
    context.lineWidth = stringThickness;
    context.moveTo(0, height/2);
    context.lineTo(width, height/2);
    context.moveTo(fretDistances[0]+10, height/2);

    context.quadraticCurveTo((width - fretDistances[0]+10)/2, oscillationAmplitude, width, height/2)
    context.stroke();
    context.fill();
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

function createGradientForOscillation(context)
{
    var gradient = context.createLinearGradient(0,0, 0,oscillationAmplitude)
    context.clearRect(0, 0, width, 20);

    gradient.addColorStop(0.0, "#60ffffff");
    gradient.addColorStop(0.5, "#AAffffff");
    gradient.addColorStop(1, "#60ffffff");

    return gradient;
}

function onNotePressed()
{
    if (stringOscillationAnimation.running)
    {
        stringOscillationAnimation.restart();
    }
    else
    {
        stringOscillationAnimation.start();
    }
}

function createNotes(height, fretThickness)
{
    var notesNumber = fretDistances.length
    var octaveCounter = stringItem.stringInitialNoteOctave;
    var fd = fretDistances;
    var l = notes.length;

    var openStringSettings = {
        "x": 0,
        "y": 0,
        "width": 20,
        "height": height,
        "octave":octaveCounter,
        "name":d.notesNames[d.notesNames.indexOf(initialNote)],
        "normalLabelBackgroundColor":'#CCFFA500',
        "normalLabelBorderColor":'#C11B17',
        "normalLabelTextColor":"#FFFFFF"
    };

    notes[0] = createNote(openStringSettings);
    connectSignalToSlots(notes[0]);
    notes[0].showLabels(showNotesLabels);
    notes[0].displayActive(true);
    for (var i = 0, nameIndex = d.notesNames.indexOf(initialNote) + 1; i < notesNumber - 1 ; ++i, ++nameIndex)
    {
        var settings = {
            "x": fretDistances[i] + fretThickness/2,
            "y": 0,
            "width": fretDistances[i+1] - fretDistances[i] - fretThickness,
            "height": height,
            "octave":octaveCounter,
            "name":d.notesNames[nameIndex%12],
            "normalLabelBackgroundColor":'#CCFFA500',
            "normalLabelBorderColor":'#C11B17',
            "normalLabelTextColor":"#FFFFFF"
        };

        if (nameIndex%12 == 0 && nameIndex != 0)
        {
            ++octaveCounter;
        }

        notes[i+1] = createNote(settings);
        connectSignalToSlots(notes[i+1]);
        notes[i+1].showLabels(showNotesLabels);
        notes[i+1].displayActive(i < activeFretsNumber);
    }
}

function createNote(settings)
{
    var note;
    var component = Qt.createComponent("qrc:/Note.qml");
    if( component.status !== Component.Ready )
    {
        if( component.status === Component.Error )
        {
            console.debug("Error:"+ component.errorString() );
        }
    }
    else
    {
        note = component.createObject(stringItem,settings);
    }
    return note;
}

function connectSignalToSlots(note)
{
    note.notePressed.connect(notePressed);
    note.nonLabeledDisplayingStopped.connect(nonLabeledDisplayingStopped);
    note.notePressed.connect(onNotePressed);
}


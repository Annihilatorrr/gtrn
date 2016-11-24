function createComponentFromQmlFile(fileName)
{
    var settingsWindow;
    var component = Qt.createComponent(fileName);
    if (component.status === Component.Ready)
    {
        settingsWindow = component.createObject(root);
    }
    else
    {
        console.log("Error while creating component from:", filename, ": ", component.errorString())
    }
    return settingsWindow;
}

function calculateFretDistances()
{
    var canvasWidth = width;
    var fretBeginning = 30;
    var stretchCoefficient = (canvasWidth - 50)/Math.ceil(canvasWidth - (canvasWidth / Math.pow(2,(24/12.0))));
    fretDistances[0] = 0;
    for (var i = 0; i <= fretsNumber; ++i)
    {
        var fraction = Math.pow(2,(i/12.0));
        var distance = fretBeginning + Math.ceil(canvasWidth - (canvasWidth / fraction))*stretchCoefficient
        fretDistances[i+1] = distance;
    }
}

function onStringPicked(octave, name)
{
    if (!isMuted)
    {
        console.log("Note pressed", octave, name);
        notePressed(octave, name);
    }
    else
    {
        console.log("muted");
    }
}

function createStrings(stringNumber, parent)
{
    var stringMargin = 5;

    var stringActiveArea = 20;
    var stringSpacing = (height - stringMargin*2 - stringNumber*stringActiveArea)/(stringNumber - 1)
    for (var i = 0; i < stringNumber; ++i)
    {
        var component = Qt.createComponent("qrc:/GuitarString.qml");
        var initialNoteOctave = tuning[i].slice(-1);
        var initialNote = tuning[i].slice(0, -1);
        var fff = fretsNumber;
        var fretDistancesToDisplay = fretDistances.slice(0, fretsNumber + 2)
        var settings = {
            "x": 0,
            "y": stringMargin + i*(stringSpacing + stringActiveArea),
            "width": width,
            "height": stringActiveArea,
            "activeAreaHeight":stringActiveArea,
            "fretThickness":3,
            "visible":true,
            "fretDistances": fretDistancesToDisplay,
            "initialNote":initialNote,
            "initialNoteOctave":initialNoteOctave
        };

        var guitarString = strings[i];
        if (strings[i] !== undefined)
        {
            strings[i].destroy();
        }

        strings[i] = component.createObject(parent,settings);
        var dd = component.errorString();
        strings[i].showNotesLabels = showNotesLabels;
        strings[i].notePressed.connect(onStringPicked);
        console.log("Setting for string #", i, " showNotesLabels = ", showNotesLabels)
    }
}

function createGradientForFret(context)
{
    var gradient = context.createLinearGradient(0,0, 0,height )
    gradient.addColorStop(0, "#404040");
    gradient.addColorStop(0.05, "#C5CECE");
    gradient.addColorStop(0.5, "#e6e6e6");
    gradient.addColorStop(0.95, "#C5CECE");
    gradient.addColorStop(1, "#404040");
    return gradient;
}

function drawFretboard(canvas) {
    var ctx = canvas.getContext('2d');
    ctx.save();
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = fillStyle;

    // first fret
    ctx.beginPath();

    ctx.fillRect(fretDistances[1], 0, 10, height);

    // other frets
    ctx.beginPath();

    ctx.lineWidth = 3;
    ctx.strokeStyle = createGradientForFret(ctx);
    for (var i = 2; i <= fretsNumber + 1; ++i)
    {
        ctx.moveTo(fretDistances[i], 0);
        ctx.lineTo(fretDistances[i],height);
    }
    ctx.stroke();
    ctx.restore();
}

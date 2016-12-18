var chromaticMultipliers = [1.0, 1.05946, 1.122462, 1.189207, 1.259921, 1.334839, 1.414213, 1.498307, 1.587401, 1.681792, 1.781797, 1.887748, 2.0,
                            2.118926, 2.244924, 2.378414, 2.519842, 2.669679, 2.828427, 2.996614, 3.174802, 3.363585, 3.563594, 3.775497, 4];

function createComponentFromQmlFile(fileName)
{
    var component = Qt.createComponent(fileName);
    var settingsWindow;
    if (component.status === Component.Ready)
    {
        settingsWindow = component.createObject(root);
    }
    else
    {
        console.debug("Error while creating component from:", filename, ": ", component.errorString())
    }
    return settingsWindow;
}

function calculateFretDistances()
{
    var canvasWidth = width;
    var fretBeginning = 25;
    var stretchCoefficient = (canvasWidth - 50)/Math.ceil(canvasWidth - (canvasWidth / Math.pow(2,(24/12.0))));
    absoluteFretDistances[0] = 0;
    for (var i = 0; i <= fretsNumber; ++i)
    {
        var distanceFromFirstFret = Math.ceil(canvasWidth - (canvasWidth / chromaticMultipliers[i]))*stretchCoefficient
        absoluteFretDistances[i+1] = fretBeginning + distanceFromFirstFret;
    }
}

function onStringPicked(octave, name)
{
    if (!isMuted)
    {
        console.debug("Sounds", octave, name);
        notePressed(octave, name);
    }
    else
    {
        console.debug("Muted", octave, name);
    }
}

function createStrings(stringNumber, parent)
{
    console.debug("Creating strings", (!trainingMode && showNotesLabels) ? "with" : "without", "labels")
    var edgeMargin = 10;

    var labelHeight = 20;
    var spaceBetweenStrings = (height - edgeMargin*2)/(stringNumber - 1)

    for (var i = 0; i < stringNumber; ++i)
    {
        var component = Qt.createComponent("qrc:/GuitarString.qml");
        var stringInitialNoteOctave = tuning[i].slice(-1);
        var initialNote = tuning[i].slice(0, -1);
        var fretDistancesToDisplay = absoluteFretDistances.slice(0, fretsNumber + 2)
        var settings = {
            "x": 0,
            "y": edgeMargin + i*spaceBetweenStrings - labelHeight/2,
            "width": width,
            "height": labelHeight,
            "fretThickness":3,
            "stringWidth":i,
            "visible":true,
            "fretDistances": fretDistancesToDisplay,
            "initialNote":initialNote,
            "stringInitialNoteOctave":stringInitialNoteOctave
        };

        if (strings[i] !== undefined)
        {
            strings[i].destroy();
        }

        strings[i] = component.createObject(parent,settings);
        strings[i].showNotesLabels = !trainingMode && showNotesLabels;
        strings[i].notePressed.connect(onStringPicked);
        strings[i].nonLabeledDisplayingStopped.connect(nonLabeledDisplayingStopped);
    }
}

function createGradientForFret(context)
{
    var gradient = context.createLinearGradient(0,0, 0,height )
    gradient.addColorStop(0, "#404040");
    gradient.addColorStop(0.02, "#C5CECE");
    gradient.addColorStop(0.1, "#E6E6E6");
    gradient.addColorStop(0.1, "#E6E6E6");
    gradient.addColorStop(0.98, "#C5CECE");
    gradient.addColorStop(1, "#404040");
    return gradient;
}

function createGradientForFirstFret(context)
{
    var gradient = context.createLinearGradient(0,0, 0,height )
    gradient.addColorStop(0, "#696969");
    gradient.addColorStop(0.05, "#F8F8FF");
    gradient.addColorStop(0.5, "#FFFFFF");
    gradient.addColorStop(0.95, "#F8F8FF");
    gradient.addColorStop(1, "#696969");
    return gradient;
}

function drawFretboard(canvas) {
    console.debug("Drawing fretboard");
    var ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // first fret
    ctx.beginPath();
    ctx.fillStyle = createGradientForFirstFret(ctx);
    ctx.fillRect(absoluteFretDistances[1], 0, 10, height);

    ctx.fillStyle = fretMarkerColor;
    ctx.lineWidth = fretThickness;
    ctx.strokeStyle = createGradientForFret(ctx);

    console.debug("Drawing ", fretsNumber, " frets")
    for (var i = 2; i <= fretsNumber + 1; ++i)
    {
        ctx.beginPath();
        ctx.moveTo(absoluteFretDistances[i], 0);
        ctx.lineTo(absoluteFretDistances[i],height);
        ctx.stroke();

        switch(i)
        {
        case 3:
        case 7:
        case 5:
        case 9:
        case 15:
        case 17:
        case 19:
        case 21:
            drawFilledCircle((absoluteFretDistances[i]+absoluteFretDistances[i+1])/2, height/2, 8, ctx)
            break;
        case 12:
        case 24:
            drawFilledCircle((absoluteFretDistances[i]+absoluteFretDistances[i+1])/2, height/3, 8, ctx)
            drawFilledCircle((absoluteFretDistances[i]+absoluteFretDistances[i+1])/2, 2*height/3, 8, ctx)
        }
    }

}

function drawFilledCircle(x, y, radius, context)
{
    context.save()

    context.beginPath()
    context.moveTo(x, y)
    context.arc(x, y, radius, 0, Math.PI*2, true);
    context.fill()

    context.restore()
}

function setNotesLabelsVisible(visible)
{
    strings.forEach(function(item)
    {
        item.showNotesLabels = visible;
    });

    console.debug("Settings strings", (!trainingMode && showNotesLabels) ? "with" : "without", "labels")
}

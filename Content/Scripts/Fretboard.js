.import "common.js" as CommonJs

var maxFretsNumber = 24
var widthAfterZeroFret = 30;

var chromaticMultipliers = [1.05946, 1.122462, 1.189207, 1.259921, 1.334839, 1.414213, 1.498307, 1.587401, 1.681792, 1.781797, 1.887748, 2.0,
                            2.118926, 2.244924, 2.378414, 2.519842, 2.669679, 2.828427, 2.996614, 3.174802, 3.363585, 3.563594, 3.775497, 4];

function calculateFretDistances()
{
    var canvasWidth = width;
    var fretboardBeginning = widthAfterZeroFret;
    var stretchCoefficient = (canvasWidth - 50)/Math.ceil(canvasWidth - (canvasWidth / Math.pow(2,(maxFretsNumber/12.0))));
    fretBoard.absoluteFretDistances[0] = fretboardBeginning;
    for (var i = 1; i <= maxFretsNumber; ++i)
    {
        var distanceFromZeroFret = Math.ceil(canvasWidth - (canvasWidth / chromaticMultipliers[i-1]))*stretchCoefficient
        fretBoard.absoluteFretDistances[i] = fretboardBeginning + distanceFromZeroFret;
    }
}

function onStringPicked(octave, name)
{
    if (!isMuted)
    {
        notePressed(octave, name);
        console.debug("Sounds", octave, name);
    }
    else
    {
        console.debug("Muted", octave, name);
    }
}

function createStrings(componentFileName, stringNumber, parent)
{
    console.debug("Creating strings", (!trainingMode && showNotesLabels) ? "with" : "without", "labels")

    var spaceBetweenStrings = (height - edgeMargin*2)/(stringNumber - 1)

    for (var i = 0; i < stringNumber; ++i)
    {
        var stringInitialNoteOctave = tuning[i].slice(-1);
        var initialNote = tuning[i].slice(0, -1);
        var fretDistancesToDisplay = fretBoard.absoluteFretDistances.slice(0, maxFretsNumber + 2)
        var settings = {
            "x": 0,
            "y": edgeMargin + i*spaceBetweenStrings - labelHeight/2,
            "width": width,
            "height": labelHeight,
            "fretThickness":3,
            "stringThickness":1,
            "visible":true,
            "fretDistances": fretDistancesToDisplay,
            "activeFretsNumber":activeFretsNumber,
            "initialNote":initialNote,
            "stringInitialNoteOctave":stringInitialNoteOctave
        };

        if (strings[i] !== undefined)
        {
            strings[i].destroy();
        }

        strings[i] = createString(componentFileName, parent, settings)
    }
}

function createString(componentFileName, parent, settings)
{
    var string = CommonJs.createObjectFromQmlFile(componentFileName, parent, settings)
    string.showNotesLabels = !trainingMode && showNotesLabels;
    string.notePressed.connect(onStringPicked);
    string.nonLabeledDisplayingStopped.connect(nonLabeledDisplayingStopped);
    return string;
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

function createGradientForZeroFret(context)
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
    ctx.save();

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // zero fret
    ctx.beginPath();
    ctx.fillStyle = createGradientForZeroFret(ctx);
    ctx.fillRect(fretBoard.absoluteFretDistances[0], 0, 10, height);

    console.debug("Drawing ", maxFretsNumber, " frets")
    drawFrets(ctx);

    if (trainingMode)
    {
        fillNotUsedFretboardPart(ctx);
    }

    ctx.restore();

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

function drawMarkerIfNeeded(context, position)
{
    var currentFretDistance = fretBoard.absoluteFretDistances[position];
    var nextFretDistance = fretBoard.absoluteFretDistances[position+1];

    switch(position)
    {
    case 2:
    case 4:
    case 6:
    case 8:
    case 14:
    case 16:
    case 18:
    case 20:
        drawFilledCircle((currentFretDistance + nextFretDistance)/2, height>>1, 8, context)
        break;
    case 11:
    case 23:
        drawFilledCircle((currentFretDistance + nextFretDistance)/2, height/3, 8, context)
        drawFilledCircle((currentFretDistance + nextFretDistance)/2, (height/3) << 1, 8, context)
    }
}

function fillNotUsedFretboardPart(context)
{
    var x1 = fretBoard.absoluteFretDistances[activeFretsNumber];
    var x2 = fretBoard.absoluteFretDistances[maxFretsNumber];
    var notUserFretsRectangleWidth = x2 - x1;
    console.debug("Filling rect of not used frets", x1, 0, width - x1, height);
    context.fillStyle = "#80ffffff";
    context.fillRect(x1, 0, width - x1, height);
}

function drawFrets(context)
{
    context.fillStyle = fretMarkerColor;
    context.lineWidth = fretThickness;
    context.strokeStyle = createGradientForFret(context);
    for (var i = 1; i <= maxFretsNumber; ++i)
    {
        context.beginPath();
        context.moveTo(fretBoard.absoluteFretDistances[i], 0);
        context.lineTo(fretBoard.absoluteFretDistances[i], height);
        context.stroke();

        drawMarkerIfNeeded(context, i)
    }
}

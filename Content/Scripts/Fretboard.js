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
    console.log("Drawing fretboard");
    var ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = fillStyle;

    // first fret
    ctx.beginPath();
    ctx.fillRect(fretDistances[1], 0, 10, height);

    ctx.lineWidth = 3;
    ctx.strokeStyle = createGradientForFret(ctx);

    console.log("Drawing ", fretsNumber, " frets")
    for (var i = 2; i <= fretsNumber + 1; ++i)
    {
        ctx.beginPath();
        ctx.moveTo(fretDistances[i], 0);
        ctx.lineTo(fretDistances[i],height);
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
            drawFilledCircle((fretDistances[i]+fretDistances[i+1])/2, height/2, 8, ctx)
            break;
        case 12:
        case 24:
            drawFilledCircle((fretDistances[i]+fretDistances[i+1])/2, height/3, 8, ctx)
            drawFilledCircle((fretDistances[i]+fretDistances[i+1])/2, 2*height/3, 8, ctx)
        }
    }

}

function drawFilledCircle(x, y, radius, context)
{
    context.save()
    context.beginPath()
    context.moveTo(x, y)

    context.arc(x, y, radius, 0, Math.PI*2, true);
    context.fillStyle = '#ffffff';
    context.fill()
    context.restore()
}

function setNotesLabelsVisible(visible)
{
    for (var i = 0; i < stringNumber; ++i)
    {
        var sn = stringNumber;
        var sss = showNotesLabels;
         var str = strings[i];
        var dd = str.showNotesLabels;
        strings[i].showNotesLabels = visible;
        console.log("Setting for string #", i, " showNotesLabels = ", showNotesLabels)
    }
}

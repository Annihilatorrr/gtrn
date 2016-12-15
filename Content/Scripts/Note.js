function drawLabel(canvas)
{
    //console.log("Drawing note");
    var context = canvas.getContext("2d");
    clear(context);
    if (showNotesLabels)
    {
        drawMainLabel(context);
    }
}

function drawMainLabel(context)
{
    var centreX = width / 2;
    var centreY = height / 2;

    context.beginPath();
    context.arc(centreX, centreY, labelRadius, 0, 2*Math.PI, false);
    context.fillStyle = labelBackgroundColor;
    context.strokeStyle = labelBorderColor;
    context.fill();

    context.fillStyle = labelTextColor

    context.font = 'bold 10pt Arial';
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.lineWidth = 1;
    context.fillText(name, centreX, centreY);
}

function clear(context)
{
    context.clearRect(0, 0, width, height);
}

function drawLabel(canvas)
{
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
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
//    context.lineWidth = 2;
//    context.stroke();
    context.fillStyle = labelTextColor

    context.font = 'bold 9pt Arial';
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.lineWidth = 3;
    context.fillText(name, centreX, centreY);
}
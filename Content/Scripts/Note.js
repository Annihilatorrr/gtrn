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
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.arc(centreX, centreY, normalLabelRadius, 0, 2*Math.PI, false);
    context.fillStyle = normalLabelBackgroundColor;
    context.strokeStyle = normalLabelBorderColor;
    context.fill();
    context.fillStyle = normalLabelTextColor
    context.font = 'bold 10pt Arial';

    context.lineWidth = 1;
    context.fillText(name, centreX, centreY);
}

function setNormalNoteStyle(context)
{

}

function setRightStyle(context)
{

}

function setWrongStyle(context)
{

}

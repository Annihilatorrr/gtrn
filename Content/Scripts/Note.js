function drawLabel(canvas)
{
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
    if (showNotesLabels || displayingState == d.nonlabeledState)
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
    context.arc(centreX, centreY, getRadius(), 0, 2*Math.PI, false);
    context.fillStyle = getBackgroundColor();
    context.strokeStyle = normalLabelBorderColor;
    context.fill();
    context.fillStyle = normalLabelTextColor
    context.font = 'bold 10pt Arial';

    context.lineWidth = 1;
    context.fillText(displayingState == d.nonlabeledState ? "?":name, centreX, centreY);
}

function getRadius()
{
    var radius = 0;
    switch(displayingState)
    {
    case d.normalState:
        radius = normalLabelRadius;
        break;
    case d.nonlabeledState:
        radius = normalLabelRadius;
        break;
    case d.correctState:
        radius = normalLabelRadius;
        break;
    case d.wrongState:
        radius = normalLabelRadius;
        break;
    }
    return radius;
}

function getBackgroundColor()
{
    var color = "white";
    switch(displayingState)
    {
    case d.normalState:
        color = normalLabelBackgroundColor;
        break;
    case d.nonlabeledState:
        color = "#ee82ee";
        break;
    case d.correctState:
        color = normalLabelBackgroundColor;
        break;
    case d.wrongState:
        color = normalLabelBackgroundColor;
        break;
    }
    return color;

}

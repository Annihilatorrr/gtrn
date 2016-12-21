function drawLabel(canvas)
{
    var context = canvas.getContext("2d");
    context.clearRect(0, 0, width, height);
    drawMainLabel(context);
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
    context.font = 'bold 11pt Arial';

    context.lineWidth = 1;
    context.fillText(displayingState == d.nonlabeledState ? "?":name, centreX, centreY + 2);
}

function getRadius()
{
    var radius = 0;
    switch(displayingState)
    {
    case d.normalVisibleState:
    case d.normalInvisibleState:
        radius = normalLabelRadius;
        break;
    case d.nonlabeledState:
        radius = normalLabelRadius;
        break;
    case d.rightState:
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
    case d.normalVisibleState:
    case d.normalInvisibleState:
        color = normalLabelBackgroundColor;
        break;
    case d.nonlabeledState:
        color = "#ee82ee";
        break;
    case d.rightState:
        color = rightNoteBackgroundColor;
        break;
    case d.wrongState:
        color = wrongNoteBackgroundColor;
        break;
    }
    return color;
}

function displayNonLabeled()
{
    displayingState = d.nonlabeledState;
    noteItem.opacity = 1.0;
    noteCanvas.requestPaint();
}

function setVisible(isVisible)
{
    displayingState = isVisible ? d.normalVisibleState : d.normalInvisibleState;
    noteItem.opacity = isVisible ? 1.0:0.0;
}

function displayNonLabeledNoteAsWrong()
{
   displayingState = d.wrongState;
   trainingModeNodeAnimation.running = true
}

function displayNonLabeledNoteAsRight()
{
    displayingState = d.rightState;
    trainingModeNodeAnimation.running = true
}

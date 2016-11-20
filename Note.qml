import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id:noteItem
    property color backgroundColor:"blue"
    property int octave:0
    property string name:""
    property int labelRadius
    property color labelBackgroundColor
    property color labelBorderColor
    property color labelTextColor

    signal notePressed(int octave, string name)
    Rectangle {
        width: parent.width
        height: parent.height
        color:"transparent"
        Canvas{
            id:noteCanvas
            anchors.fill: parent
            antialiasing:true
            onPaint: {
                var context = getContext("2d");

                context.reset();

                var centreX = width / 2;
                var centreY = height / 2;

                context.beginPath();
                context.arc(centreX, centreY, labelRadius, 0, 2*Math.PI, false);
                context.fillStyle = labelBackgroundColor;
                context.strokeStyle = labelBorderColor;
                context.fill();
                context.lineWidth = 2;
                context.shadowColor = "#2ed5fa";
//                   context.shadowOffsetX = 2;
//                   context.shadowOffsetY = 2;
                   //context.shadowBlur = 2;
                context.stroke();
                context.fillStyle = labelTextColor

                context.font = 'bold 9pt Arial';
                context.textAlign = 'center';
                context.textBaseline = 'middle';
                context.lineWidth = 3;
                context.fillText(name, centreX, centreY);
                //context.strokeText(name, centreX, centreY);
            }

        }
        MouseArea{
            onPressed: {
                noteItem.notePressed(noteItem.octave, noteItem.name)
                noteCanvas.requestPaint()
            }
            anchors.fill: parent
        }
    }
}


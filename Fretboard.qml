import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: fretItem
    property color backgroundColor:"cyan"
    property int fretNumber:22
    property int stringNumber:3
    property variant tuning:[]
    Rectangle {
        id:fretRect
        width: parent.width
        height: parent.height
        color:parent.backgroundColor
        border.width: 2
        border.color: "black"
        property int fretNumber:parent.fretNumber
        property int stringNumber:parent.stringNumber
        property variant strings:[]
        Canvas {
            id: canvas
            property variant fretDistances:[]
            property int stringNumber:parent.stringNumber

            function caulculateFretDistances()
            {
                var canvasWidth = width;
                var stretchCoefficient = (canvasWidth - 50)/Math.ceil(canvasWidth - (canvasWidth / Math.pow(2,(24/12.0))));
                for (var i = 0; i < fretNumber; ++i)
                {
                    var fraction = Math.pow(2,(i/12.0));
                    fretDistances[i] = 20 + Math.ceil(canvasWidth - (canvasWidth / fraction))*stretchCoefficient;
                }
            }

            function createStrings()
            {
                var stringMargin = 12;
                var stringActiveArea = 10;
                var stringSpacing = (height - stringMargin*2 - stringNumber*stringActiveArea)/(stringNumber - 1)
                for (var i = 0; i < stringNumber; ++i)
                {
                    var component = Qt.createComponent("GuitarString.qml");

                    var settings = {
                        "x": 0,
                        "y": stringMargin + i*(stringSpacing + stringActiveArea),
                        "width": width,
                        "height": stringActiveArea,
                        "activeAreaHeight":stringActiveArea,
                        "fretThickness":3,
                        "visible":true,
                        "fretDistances": fretDistances
                    };
                    fretRect.strings[i] = component.createObject(fretRect,settings);
                    fretRect.strings[i].notePressed.connect(function(octave, name){console.log("Note pressed", octave, name);});
                }
            }

            Component.onCompleted:{
                caulculateFretDistances()
                createStrings()
            }

            anchors.fill: parent

            antialiasing: true

            property color strokeStyle:  Qt.darker(fillStyle, 1.6)
            property color fillStyle: "#e0c31e" // yellow
            property int lineWidth: lineWidthCtrl.value
            property bool fill: true
            property bool stroke: true
            property real scale : scaleCtrl.value
            property real rotate : rotateCtrl.value

            onLineWidthChanged:requestPaint();
            onFillChanged:requestPaint();
            onStrokeChanged:requestPaint();
            onScaleChanged:requestPaint();
            onRotateChanged:requestPaint();

            onPaint: {
                var ctx = canvas.getContext('2d');
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                //ctx.translate(originX, originX);
                ctx.globalAlpha = canvas.alpha;
                ctx.strokeStyle = canvas.strokeStyle;
                ctx.fillStyle = canvas.fillStyle;
                ctx.lineWidth = 3;

                // ctx.scale(canvas.scale, canvas.scale);
                // ctx.rotate(canvas.rotate);
                ctx.beginPath();
                for (var i = 0; i < fretNumber; ++i)
                {
                    ctx.moveTo(fretDistances[i], 2);
                    ctx.lineTo(fretDistances[i],height - 2);
                }
                ctx.stroke();
                ctx.restore();
            }
        }
    }
}

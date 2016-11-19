import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: fretItem
    property color backgroundColor:"cyan"
    property int fretNumber:22
    property int stringNumber:3
    signal notePressed(int octave, string name)
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
                var fretBeginning = 30;
                var stretchCoefficient = (canvasWidth - 50)/Math.ceil(canvasWidth - (canvasWidth / Math.pow(2,(24/12.0))));
                fretDistances[0] = 0;
                for (var i = 0; i <= fretNumber; ++i)
                {
                    var fraction = Math.pow(2,(i/12.0));
                    var distance = fretBeginning + Math.ceil(canvasWidth - (canvasWidth / fraction))*stretchCoefficient
                    fretDistances[i+1] = distance;
                }
                var fd = fretDistances;
                var r = 0;
            }

            function createStrings()
            {
                var stringMargin = 5;

                var stringActiveArea = 15;
                var stringSpacing = (height - stringMargin*2 - stringNumber*stringActiveArea)/(stringNumber - 1)
                for (var i = 0; i < stringNumber; ++i)
                {
                    var component = Qt.createComponent("GuitarString.qml");
                    var initialNoteOctave = tuning[i].slice(-1);
                    var initialNote = tuning[i].slice(0, -1);
                    var settings = {
                        "x": 0,
                        "y": stringMargin + i*(stringSpacing + stringActiveArea),
                        "width": width,
                        "height": stringActiveArea,
                        "activeAreaHeight":stringActiveArea,
                        "fretThickness":3,
                        "visible":true,
                        "fretDistances": fretDistances,
                        "initialNote":initialNote,
                        "initialNoteOctave":initialNoteOctave
                    };
                    fretRect.strings[i] = component.createObject(fretRect,settings);
                    fretRect.strings[i].notePressed.connect(fretItem.notePressed);
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

            onLineWidthChanged:requestPaint();
            onScaleChanged:requestPaint();

            onPaint: {
                var ctx = canvas.getContext('2d');
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);

                ctx.globalAlpha = canvas.alpha;
                ctx.strokeStyle = canvas.strokeStyle;
                ctx.fillStyle = canvas.fillStyle;

                // first fret
                ctx.beginPath();
                ctx.lineWidth = 10;
                ctx.moveTo(fretDistances[1], 2);
                ctx.lineTo(fretDistances[1],height - 2);

                ctx.stroke();
                ctx.beginPath();
                ctx.lineWidth = 3;
                for (var i = 2; i <= fretNumber+1; ++i)
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

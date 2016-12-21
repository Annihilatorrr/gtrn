import QtQuick 2.7
import QtQuick.Controls 2.0

SequentialAnimation {
    loops: 1
    running: true

    property real opacityUpFrom
    property real opacityUpTo
    property real opacityDownFrom
    property real opacityDownTo

    property int upDuration:1000
    property int downDuration:1000
    property int pauseDuration:1000
    property var animationTarget

    NumberAnimation {
            id: opacityUpAnimation
            target: animationTarget
            property: "opacity"
            from: opacityUpFrom
            to: opacityUpTo
            duration: upDuration
            easing {type: Easing.OutCubic}
       }
    PauseAnimation { duration: pauseDuration }
    NumberAnimation {
            id:opacityDownAnimation
            target: animationTarget
            property: "opacity"
            to: opacityDownTo
            from: opacityDownFrom
            duration: downDuration
            easing {type: Easing.OutCubic}
       }
}

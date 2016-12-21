import QtQuick 2.7
import QtQuick.Controls 2.0

SequentialAnimation {

    loops: 1
    running: true
    property int radius
    property var animationTarget

    NumberAnimation {
        id: radiusUpAnimation
        target: animationTarget
        property: "normalLabelRadius"
        from: radius
        to: radius + 1
        duration: 30
        easing {type: Easing.OutCubic}
    }
    NumberAnimation {
        id:radiusDownAnimation
        target: animationTarget
        property: "normalLabelRadius"
        to: radius
        from: radius + 1
        duration: 500
        easing {type: Easing.OutCubic}
    }
    PauseAnimation { duration: 1000 }
    NumberAnimation {
        id:opacityDownAnimation
        target: animationTarget
        property: "opacity"
        to: 0
        from: 1
        duration: 1000
        easing {type: Easing.OutCubic}
   }
}

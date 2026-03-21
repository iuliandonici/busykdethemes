/*
 *   Copyright 2023 Jorge Espinal <jfespinal at store.kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 3+,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 */

import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick
import org.kde.kirigami 2 as Kirigami

Rectangle {
    id: root
    color: "#000000"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Rectangle {

        property int sizeAnim: 400

        id: imageSource
        width:  parent.width
        height: parent.height
        color:  "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        clip: true;
 
        AnimatedImage { 
            id: face
            source: "images/matrix_code.gif"
            paused: false 
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width:  parent.width
            height: parent.height
            smooth: true
            visible: true 
         }
    }

        Image {
            id: plasmaLogo
            y: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: units.gridUnit
            source: "images/plasma.svgz"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3

        }

        Row {
            opacity: 0.5
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                // right: parent.right
                margins: units.gridUnit
            }
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                color: "#7eb761"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: "Welcome to Plasma"
            }
            Image {
                source: "images/kde.svgz"
                sourceSize.height: units.gridUnit * 2
                sourceSize.width: units.gridUnit * 2
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}

import QtQuick 2.9
import QtQuick.Controls 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import QtGraphicalEffects 1.0

Item {
    id: root

    anchors.fill: parent
    clip: true

    property real radius: 0

    property url backgroundImage: ""

    Item {
        anchors.fill: parent

        Image {
            id: image

            width: parent.width
            anchors.centerIn: parent
            source: backgroundImage
            fillMode: Image.PreserveAspectFit
            clip: true
            visible: false
        }

        Rectangle {
            id: mask

            anchors.fill: parent
            radius: root.radius
            visible: false
        }

        OpacityMask {
            anchors.fill: image
            source: image
            maskSource: mask
        }
    }

    Item {
        anchors.fill: parent

        LinearGradient {
            id: background

            anchors.fill: parent

            start: Qt.point(0, 0)
            end: Qt.point(0, height)

            gradient: Gradient {
                GradientStop { position: 0.0; color: colors.red_dark_70 }
                GradientStop { position: 1.0; color: colors.red_dark_100 }
            }

            visible: false
        }

        Rectangle {
            id: backgroundMask

            anchors.fill: parent
            radius: root.radius
            visible: false
        }

        OpacityMask {
            anchors.fill: background
            source: background
            maskSource: backgroundMask
        }
    }
}

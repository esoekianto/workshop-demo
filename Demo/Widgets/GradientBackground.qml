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

    property color gradientStart: colors.red_dark_70
    property color gradientEnd: colors.red_dark_100

    Item {
        anchors.fill: parent

        Item {
            id: content

            anchors.fill: parent
            visible: false

            Image {
                anchors.fill: parent
                source: backgroundImage
                mipmap: true
            }

            LinearGradient {
                anchors.fill: parent

                start: Qt.point(0, 0)
                end: Qt.point(0, height)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: gradientStart }
                    GradientStop { position: 1.0; color: gradientEnd }
                }
            }
        }

        Rectangle {
            id: mask

            anchors.fill: parent
            radius: root.radius
            visible: false
        }

        OpacityMask {
            anchors.fill: content
            source: content
            maskSource: mask
        }
    }
}

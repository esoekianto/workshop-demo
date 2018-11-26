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
                    GradientStop { position: 0.0; color: colors.red_dark_70 }
                    GradientStop { position: 1.0; color: colors.red_dark_100 }
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

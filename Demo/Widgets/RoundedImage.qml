import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import QtGraphicalEffects 1.0

Item {
    id: root

    property alias icon: image.source

    property real radius: 0
    property real borderWidth: 1 * constants.scaleFactor

    property color borderColor: colors.white

    property bool isBorderDisplayed: false

    Item {
        anchors.fill: parent

        Image{
            id: image

            anchors.fill: parent
            mipmap: true
            fillMode: Image.PreserveAspectFit
            visible: false

            Rectangle {
                anchors.fill: parent
                radius: root.radius
                color: colors.transparent
                border.width: isBorderDisplayed ? borderWidth : 0
                border.color: borderColor
            }
        }

        Rectangle {
            id: imageMask

            anchors.fill: parent
            radius: root.radius
            visible: false
        }

        OpacityMask {
            anchors.fill: image
            source: image
            maskSource: imageMask
        }
    }
}


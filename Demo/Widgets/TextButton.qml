import QtQuick 2.9
import QtQuick.Controls 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

TouchGestureArea {
    id: root

    property alias content: content

    property color textColor: colors.white

    property string buttonText: ""

    property real textSize: 16 * constants.scaleFactor

    property string fontFamily: fonts.system

    Label {
        id: content

        width: Math.max(160 * constants.scaleFactor, this.implicitWidth)
        height: parent.height

        text: buttonText
        color: textColor
        font.family: fontFamily
        font.pixelSize: textSize
        elide: Text.ElideRight
        clip: true

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        leftPadding: 16 * constants.scaleFactor
        rightPadding: 16 * constants.scaleFactor
    }
}


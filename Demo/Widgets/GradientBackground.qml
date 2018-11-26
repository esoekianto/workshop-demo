import QtQuick 2.9
import QtQuick.Controls 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent

    property url backgroundImage: ""

    Image {
        height: parent.height
        anchors.centerIn: parent

        source: backgroundImage

        fillMode: Image.PreserveAspectFit
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

import QtQuick 2.9

import ArcGIS.AppFramework 1.0

Item {
    id: root

    // Screen scale factor
    readonly property real scaleFactor: AppFramework.displayScaleFactor

    // Animation
    readonly property int normalDuration: 250
    readonly property int fastDuration: 250
}

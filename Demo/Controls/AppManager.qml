import QtQuick 2.9

import ArcGIS.AppFramework 1.0

Item {
    id: appManager

    property real maximumScreenWidth: app.width > 1000 * constants.scaleFactor ? 800 * constants.scaleFactor : 568 * constants.scaleFactor

    property bool isIphoneX: false
    property bool isUsingDefaultFont: false

    function initialize() {
        // check device
        isIphoneX = AppFramework.systemInformation.model.indexOf("iPhone X") > -1;

        // load font
        if (!isUsingDefaultFont)
            fonts.loadFonts();
    }
}

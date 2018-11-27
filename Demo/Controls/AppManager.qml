import QtQuick 2.9
import QtQuick.Controls 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Authentication 1.0

Item {
    id: appManager

    property real maximumScreenWidth: app.width > 1000 * constants.scaleFactor ? 800 * constants.scaleFactor : 568 * constants.scaleFactor

    property bool isiPhoneX: false
    property bool isUsingDefaultFont: false
    property bool isiOS: Qt.platform.os === "ios"
    property bool ismacOS: Qt.platform.os === "osx"
    property bool isAutoSignIn: false

    Connections {
        target: BiometricAuthenticator

        onAccepted: {
            stackView.push(components.homePageComponent, StackView.Immediate);
        }

        onRejected: {

        }
    }

    function initialize() {
        // check device
        isiPhoneX = AppFramework.systemInformation.model.indexOf("iPhone X") > -1;

        // check database
        isAutoSignIn = app.settings.value("isAutoSignIn", false);

        // load font
        if (!isUsingDefaultFont)
            fonts.loadFonts();
    }
}

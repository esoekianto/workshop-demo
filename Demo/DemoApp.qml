import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import "Assets" as Assets
import "Controls" as Controls

import "Views/HomePages"
import "Views/LandingPages"

App {
    id: app

    width: 421
    height: 725

    Material.background: colors.red_dark_100

    // Reference
    property alias colors: colors
    property alias constants: constants
    property alias strings: strings
    property alias fonts: fonts
    property alias images: images
    property alias appManager: appManager

    // Pages
    Component {
        id: landingPageComponent

        LandingPage {}
    }

    Component {
        id: homePageComponent

        HomePage {}
    }

    // Assets
    Assets.Colors { id: colors }
    Assets.Constants { id: constants }
    Assets.Strings { id: strings }
    Assets.Fonts { id: fonts }
    Assets.Images { id: images }

    // Controls
    Controls.AppManager {
        id: appManager
    }

    // Stack view
    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: landingPageComponent
    }

    Component.onCompleted: {
        initialize();
    }

    function initialize() {
        appManager.initialize();
    }
}

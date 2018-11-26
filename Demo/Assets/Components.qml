import QtQuick 2.9

import "../Views/HomePages" as HomePages
import "../Views/LandingPages" as LandingPages
import "../Widgets" as Widgets

Item {
    id: components

    property alias landingPageComponent: landingPageComponent
    property alias homePageComponent: homePageComponent
    property alias gradientBackgroundComponent: gradientBackgroundComponent

    // Pages
    Component {
        id: landingPageComponent

        LandingPages.LandingPage {}
    }

    Component {
        id: homePageComponent

        HomePages.HomePage {}
    }

    // Widgets
    Component {
        id: gradientBackgroundComponent

        Widgets.GradientBackground {}
    }
}

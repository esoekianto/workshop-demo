import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import "../MainPages" as MainPages
import "../../Widgets" as Widgets

Page {
    id: homePage

    Material.background: colors.red_dark_100

    StackLayout {
        id: homePageStackLayout

        anchors.fill: parent
        currentIndex: 0

        MainPages.InfoPage {}

        MainPages.MapPage {}

        MainPages.SettingsPage {}
    }

    footer: TabBar {
        id: homePageTabBar

        width: parent.width
        height: 64 * constants.scaleFactor + (appManager.isIphoneX ? 28 * constants.scaleFactor : 0)

        Material.background: colors.red
        Material.accent: colors.yellow
        Material.elevation: 8

        bottomPadding: appManager.isIphoneX ? 28 * constants.scaleFactor : 0

        currentIndex: 0

        spacing: 0

        onCurrentIndexChanged: {
            homePageStackLayout.currentIndex = this.currentIndex;
        }

        Repeater {
            model: homePageStackLayout.count

            delegate: Widgets.TabButton {
                height: parent.height

                imageSource:
                    switch (index) {
                    case 0:
                        return images.listIcon;

                    case 1:
                        return images.mapIcon;

                    case 2:
                        return images.settingsIcon;

                    default:
                        return "";
                    }

                imageColor: checked ? colors.yellow : colors.white
            }
        }
    }
}

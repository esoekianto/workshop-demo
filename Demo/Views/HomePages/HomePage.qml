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

    property var tabBarIcons: [images.list_icon, images.map_icon, images.settings_icon]

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
        height: 64 * constants.scaleFactor + (appManager.isiPhoneX ? 28 * constants.scaleFactor : 0)

        Material.background: colors.red
        Material.accent: colors.yellow
        Material.elevation: 8

        bottomPadding: appManager.isiPhoneX ? 28 * constants.scaleFactor : 0

        currentIndex: 0

        spacing: 0

        onCurrentIndexChanged: {
            homePageStackLayout.currentIndex = this.currentIndex;
        }

        Repeater {
            model: homePageStackLayout.count

            delegate: Widgets.TabButton {
                height: parent.height

                imageSource: tabBarIcons[index]

                imageColor: checked ? colors.yellow : colors.white
            }
        }
    }
}

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ArcGIS.AppFramework 1.0

import "../InfoPages" as InfoPages

Page {
    id: infoPage

    SwipeView {
        id: infoPageSwipeView

        anchors.fill: parent
        currentIndex: 0
        interactive: false

        InfoPages.InfoListPage {}

        InfoPages.InfoElementPage {}
    }
}

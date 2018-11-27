import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

Rectangle {
    id: root

    property string title: ""

    property color accent: colors.yellow

    property bool isChecked: false

    signal clicked()

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: true

            text: title
            color: colors.white
            font.family: fonts.sf_pro_display
            font.pixelSize: 16 * constants.scaleFactor
            elide: Text.ElideRight
            clip: true

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter

            leftPadding: 16 * constants.scaleFactor
            rightPadding: 16 * constants.scaleFactor
        }

        Switch {
            Material.accent: root.accent
            Layout.alignment: Qt.AlignVCenter
            checked: isChecked

            onToggled: {
                root.clicked();
            }
        }
    }
}

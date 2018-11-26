import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ArcGIS.AppFramework 1.0

Page {
    id: infoListPage

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 16 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: titleLabel.implicitHeight

            Label {
                id: titleLabel

                width: Math.min(this.implicitWidth, parent.width)
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                text: strings.santas
                color: colors.white
                font.family: fonts.satisfy
                font.pixelSize: 40 * constants.scaleFactor
                elide: Text.ElideRight
                clip: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                leftPadding: 16 * constants.scaleFactor
                rightPadding: 16 * constants.scaleFactor
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: subtitleLabel.implicitHeight

            Label {
                id: subtitleLabel

                width: Math.min(this.implicitWidth, parent.width)
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                text: strings.around_the_world
                color: colors.yellow
                font.family: fonts.sf_pro_text
                font.pixelSize: 20 * constants.scaleFactor
                elide: Text.ElideRight
                clip: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                leftPadding: 16 * constants.scaleFactor
                rightPadding: 16 * constants.scaleFactor
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
            }
        }
    }
}

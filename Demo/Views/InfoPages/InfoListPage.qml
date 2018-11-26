import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ArcGIS.AppFramework 1.0

import "../../Widgets" as Widgets

Page {
    id: infoListPage

    property var infoModel: [
        { icon: images.turkey_icon, name: strings.turkey_santa_name, country: strings.turkey, description: strings.turkey_santa_description },
        { icon: images.greece_icon, name: strings.greece_santa_name, country: strings.greece, description: strings.greece_santa_description },
        { icon: images.uk_icon, name: strings.uk_santa_name, country: strings.uk, description: strings.uk_santa_description },
        { icon: images.netherlands_icon, name: strings.netherlands_santa_name, country: strings.netherlands, description: strings.netherlands_santa_description },
        { icon: images.japan_icon, name: strings.japan_santa_name, country: strings.japan, description: strings.japan_santa_description }
    ]

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
                spacing: 1
                clip: true
                model: infoModel

                delegate: Widgets.TouchGestureArea {
                    width: Math.min(parent.width, appManager.maximumScreenWidth)
                    height: 144 * constants.scaleFactor

                    Widgets.GradientBackground {

                    }

                    onClicked: {

                    }


                }
            }
        }
    }
}

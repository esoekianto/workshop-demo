import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ArcGIS.AppFramework 1.0

import "../../Widgets" as Widgets

Page {
    id: infoListPage

    property var infoModel: [
        { background: images.turkey_map_icon, icon: images.turkey_icon, name: strings.turkey_santa_name, country: strings.turkey, description: strings.turkey_santa_description },
        { background: images.greece_map_icon, icon: images.greece_icon, name: strings.greece_santa_name, country: strings.greece, description: strings.greece_santa_description },
        { background: images.uk_map_icon, icon: images.uk_icon, name: strings.uk_santa_name, country: strings.uk, description: strings.uk_santa_description },
        { background: images.netherlands_map_icon, icon: images.netherlands_icon, name: strings.netherlands_santa_name, country: strings.netherlands, description: strings.netherlands_santa_description },
        { background: images.japan_map_icon, icon: images.japan_icon, name: strings.japan_santa_name, country: strings.japan, description: strings.japan_santa_description }
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
            Layout.preferredHeight: 16 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent

                model: infoModel

                spacing: 8 * constants.scaleFactor
                clip: true

                delegate: Widgets.TouchGestureArea {
                    id: delegate

                    width: Math.min(parent.width, appManager.maximumScreenWidth) - 32 * constants.scaleFactor
                    height: 144 * constants.scaleFactor
                    anchors.horizontalCenter: parent.horizontalCenter

                    radius: 8 * constants.scaleFactor

                    onClicked: {

                    }

                    Component.onCompleted: {
                        createGradientBackground();
                    }

                    function createGradientBackground() {
                        components.gradientBackgroundComponent.createObject(
                                    extraItems, {
                                        radius: delegate.radius,
                                        backgroundImage: modelData.background
                                    });
                    }
                }
            }
        }
    }
}

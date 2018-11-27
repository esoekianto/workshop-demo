import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0

import "../../Widgets" as Widgets

Page {
    id: infoElementPage

    property url elementImage: ""

    property string elementTitle: ""
    property string elementDescription: ""

    signal navigateBack()

    header: ToolBar {
        height: 56 * constants.scaleFactor
        Material.primary: colors.red
        Material.elevation: 0

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                Layout.preferredWidth: 56 * constants.scaleFactor
                Layout.fillHeight: true

                Widgets.ImageButton {
                    imageIcon: images.navigate_back_icon

                    onClicked: {
                        navigateBack();
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    // Background
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 75 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Widgets.GradientBackground {
                radius: 8 * constants.scaleFactor
                anchors.bottomMargin: -radius
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 24 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 104 * constants.scaleFactor

            Widgets.RoundedImage {
                width: parent.width
                height: this.width
                anchors.verticalCenter: parent.verticalCenter
                radius: this.width / 2

                icon: elementImage

                isBorderDisplayed: true
                borderWidth: 4 * constants.scaleFactor
                borderColor: colors.green
            }
        }
    }
}

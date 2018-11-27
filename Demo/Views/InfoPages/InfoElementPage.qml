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
    property string elementSubtitle: ""
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
            Layout.preferredWidth: Math.min(parent.width, appManager.maximumScreenWidth)
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            Widgets.GradientBackground {
                radius: 8 * constants.scaleFactor
                anchors.bottomMargin: -radius
            }
        }
    }

    ColumnLayout {
        width: Math.min(parent.width, appManager.maximumScreenWidth)
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 24 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 104 * constants.scaleFactor

            Widgets.RoundedImage {
                width: 104 * constants.scaleFactor
                height: this.width
                anchors.centerIn: parent
                radius: this.width / 2

                icon: elementImage

                isBorderDisplayed: true
                borderWidth: 4 * constants.scaleFactor
                borderColor: colors.green
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 8 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: titleLabel.implicitHeight

            Label {
                id: titleLabel

                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                text: elementTitle
                color: colors.yellow
                font.family: fonts.sf_pro_display
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
            Layout.preferredHeight: 8 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: subtitleLabel.implicitHeight

            Label {
                id: subtitleLabel

                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                text: elementSubtitle
                color: colors.white
                font.family: fonts.sf_pro_display
                font.pixelSize: 16 * constants.scaleFactor
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
            Layout.preferredHeight: 24 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: descriptionLabel.implicitHeight

            Label {
                id: descriptionLabel

                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                text: elementDescription
                color: colors.white
                font.family: fonts.sf_pro_text
                font.pixelSize: 14 * constants.scaleFactor
                wrapMode: Label.Wrap
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
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 16 * constants.scaleFactor
        }
    }

    function reset() {
        elementImage = "";
        elementTitle = "";
        elementSubtitle = "";
        elementDescription = "";
    }
}

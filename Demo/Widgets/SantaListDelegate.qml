import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

import QtGraphicalEffects 1.0

TouchGestureArea {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 20 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                spacing: 0

                Item {
                    Layout.preferredWidth: 16 * constants.scaleFactor
                    Layout.fillHeight: true
                }

                Item {
                    Layout.preferredWidth: 104 * constants.scaleFactor
                    Layout.fillHeight: true

                    RoundedImage {
                        width: parent.width
                        height: this.width
                        anchors.verticalCenter: parent.verticalCenter
                        radius: this.width / 2

                        icon: modelData.icon

                        isBorderDisplayed: true
                        borderWidth: 4 * constants.scaleFactor
                        borderColor: colors.green
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 0

                        Label {
                            Layout.fillWidth: true

                            text: modelData.name
                            color: colors.white
                            font.family: fonts.sf_pro_text
                            font.pixelSize: 16 * constants.scaleFactor
                            elide: Text.ElideRight
                            clip: true

                            maximumLineCount: 2
                            wrapMode: Label.Wrap

                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter

                            leftPadding: 16 * constants.scaleFactor
                            rightPadding: 16 * constants.scaleFactor
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 8 * constants.scaleFactor
                        }

                        Label {
                            Layout.fillWidth: true

                            text: modelData.country
                            color: colors.white
                            font.family: fonts.sf_pro_text
                            font.pixelSize: 12 * constants.scaleFactor
                            elide: Text.ElideRight
                            clip: true

                            maximumLineCount: 2
                            wrapMode: Label.Wrap

                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter

                            leftPadding: 16 * constants.scaleFactor
                            rightPadding: 16 * constants.scaleFactor
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: 24 * constants.scaleFactor
                    Layout.fillHeight: true

                    IconImage {
                        width: 24 * constants.scaleFactor
                        height: this.width

                        source: images.navigate_next_icon
                        color: colors.yellow
                    }
                }

                Item {
                    Layout.preferredWidth: 16 * constants.scaleFactor
                    Layout.fillHeight: true
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 20 * constants.scaleFactor
        }
    }
}


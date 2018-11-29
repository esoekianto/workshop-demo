import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0

import "../../Widgets" as Widgets

Page {
    id: settingsPage

    property string username: "John Doe"

    Flickable {
        id: flickable

        anchors.fill: parent
        contentWidth: this.width
        contentHeight: flickableColumn.height
        clip: true

        ColumnLayout {
            id: flickableColumn

            width: Math.min(parent.width, appManager.maximumScreenWidth)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 24 * constants.scaleFactor
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: titleLabel.implicitHeight

                Label {
                    id: titleLabel

                    width: Math.min(this.implicitWidth, parent.width)
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: strings.settings
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
                Layout.preferredHeight: 24 * constants.scaleFactor
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: userProfileColumn.height

                ColumnLayout {
                    id: userProfileColumn

                    width: Math.min(parent.width, appManager.maximumScreenWidth)
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: userProfileLabel.implicitHeight

                        Label {
                            id: userProfileLabel

                            width: parent.width
                            anchors.horizontalCenter: parent.horizontalCenter

                            text: strings.profile
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
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 16 * constants.scaleFactor
                    }

                    Widgets.TouchGestureArea {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 72 * constants.scaleFactor
                        color: colors.red

                        RowLayout {
                            anchors.fill: parent
                            spacing: 0

                            Item {
                                Layout.preferredWidth: 16 * constants.scaleFactor
                                Layout.fillHeight: true
                            }

                            Item {
                                Layout.preferredWidth: 40 * constants.scaleFactor
                                Layout.fillHeight: true

                                Widgets.RoundedImage {
                                    width: parent.width
                                    height: this.width
                                    anchors.centerIn: parent
                                    radius: this.width / 2

                                    icon: images.user_profile_icon

                                    isBorderDisplayed: false
                                }
                            }

                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: username
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
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 24 * constants.scaleFactor
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: settingsColumn.height

                ColumnLayout {
                    id: settingsColumn

                    width: Math.min(parent.width, appManager.maximumScreenWidth)
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: settingsLabel.implicitHeight

                        Label {
                            id: settingsLabel

                            width: parent.width
                            anchors.horizontalCenter: parent.horizontalCenter

                            text: strings.settings
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
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 16 * constants.scaleFactor
                    }

                    Widgets.Lists {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 56 * constants.scaleFactor
                        color: colors.red

                        title: strings.auto_sign_in

                        isChecked: appManager.isAutoSignIn

                        onClicked: {
                            appManager.isAutoSignIn = !appManager.isAutoSignIn;
                            app.settings.setValue("isAutoSignIn", appManager.isAutoSignIn);
                        }
                    }

                    // You need to write extra logic for the visibility of this section
                    Widgets.Lists {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 56 * constants.scaleFactor
                        color: colors.red

                        title: appManager.isiPhoneX ? strings.face_id : (appManager.isiOS || appManager.ismacOS ? strings.touch_id : strings.fingerprint)

                        onClicked: {
                            appManager.isBiometricAuthenticationEnabled = !appManager.isBiometricAuthenticationEnabled
                            app.settings.setValue("isBiometricAuthenticationEnabled", appManager.isBiometricAuthenticationEnabled)
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 32 * constants.scaleFactor
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 56 * constants.scaleFactor

                Widgets.TextButton {
                    anchors.fill: parent
                    color: colors.red

                    fontFamily: fonts.sf_pro_text

                    buttonText: strings.sign_out

                    onClicked: {
                        stackView.pop(StackView.Immediate);
                    }
                }
            }
        }
    }
}

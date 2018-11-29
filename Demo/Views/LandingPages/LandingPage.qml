import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0
import ArcGIS.AppFramework.Authentication 1.0

import "../../Widgets" as Widgets

Page {
    id: landingPage

    Widgets.GradientBackground {
        backgroundImage: images.tree_icon
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 108 * constants.scaleFactor
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
                font.pixelSize: 56 * constants.scaleFactor
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
            Layout.preferredHeight: subtitleLabel.implicitHeight

            Label {
                id: subtitleLabel

                width: Math.min(this.implicitWidth, parent.width)
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                text: strings.around_the_world
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
            Layout.fillHeight: true
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 56 * constants.scaleFactor

            Widgets.TextButton {
                width: content.width
                height: parent.height
                radius: this.height / 2
                color: colors.green

                anchors.centerIn: parent

                fontFamily: fonts.sf_pro_display

                buttonText: strings.sign_in

                onClicked: {
                    if (appManager.usesBiometricAuthentication)
                    {
                        if (BiometricAuthenticator.supported && BiometricAuthenticator.activated) {
                            BiometricAuthenticator.authenticate()
                        } else {
                            console.log("Not supported")
                            stackView.push(components.homePageComponent, StackView.Immediate);
                        }
                    } else {
                        stackView.push(components.homePageComponent, StackView.Immediate);
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 68 * constants.scaleFactor
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: appManager.isiPhoneX ? 28 * constants.scaleFactor : 0
        }
    }
}

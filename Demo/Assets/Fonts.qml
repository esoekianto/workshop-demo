import QtQuick 2.9

import ArcGIS.AppFramework 1.0

Item {
    id: fonts

    property string system: Qt.font({ pixelSize: 16 }).family

    property string satisfy: system

    property string sf_pro_display: system
    property string sf_pro_text: system

    FileFolder {
        id: fontsFolder

        url: "Fonts"
    }

    Component {
        id: fontLoader

        FontLoader {
            property string fileName

            source: fontsFolder.fileUrl(fileName)

            onStatusChanged: {
                if (status === FontLoader.Ready) {
                    switch (name) {
                    case "Satisfy":
                        satisfy = name;
                        break;

                    case "SF Pro Display":
                        sf_pro_display = name;
                        break;

                    case "SF Pro Text":
                        sf_pro_text = name;
                        break;
                    }
                }

                if (status === FontLoader.Error)
                    console.error("The Font %1 can not be loaded!".arg(name));
            }
        }
    }

    function loadFonts() {
        var fileNames = fontsFolder.fileNames();

        for (var i in fileNames) {
            var fileName = fileNames[i];
            var loader = fontLoader.createObject
                    (fonts,
                     {
                         fileName: fileName
                     });
        }
    }
}

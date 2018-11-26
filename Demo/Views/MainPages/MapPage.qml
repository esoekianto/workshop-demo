import QtQuick 2.9
import QtQuick.Controls 2.2

import Esri.ArcGISRuntime 100.4

Page {
    id: mapPage

    SimpleRenderer{
        id: simpleRender

        PictureMarkerSymbol {
            id: defaultSymbol

            width: 20
            height: 20
            url: images.map_pin_icon
        }
    }

    // Map view UI presentation at top
    MapView {
        id: mapView

        anchors.fill: parent

        Map {
            BasemapDarkGrayCanvasVector{}

            onLoadStatusChanged: {
                if (loadStatus === Enums.LoadStatusLoaded) {
                    for (var i = 0; i < 5; i++)
                        addGraphics();
                }
            }
        }

        GraphicsOverlay {
            id: graphicsOverlay

            renderer: simpleRender
        }
    }

    function addGraphics() {
        // create a graphic
        var point = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: getRandomX(),
                        y: getRandomY(),
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphic = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: point
                    });

        // add the graphic to the graphics overlay
        graphicsOverlay.graphics.append(graphic);
    }

    function getRandomX() {
        return Math.floor(-226000 + getRandomNumber());
    }

    function getRandomY() {
        return Math.floor(6550000 + getRandomNumber());
    }

    function getRandomNumber() {
        return Math.floor((Math.random() * 10000000) + 1);
    }
}

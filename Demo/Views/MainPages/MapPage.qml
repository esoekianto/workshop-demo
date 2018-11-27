import QtQuick 2.9
import QtQuick.Controls 2.2

import Esri.ArcGISRuntime 100.4

Page {
    id: mapPage

    SimpleRenderer{
        id: simpleRender

        PictureMarkerSymbol {
            id: defaultSymbol

            width: 20 * constants.scaleFactor
            height: 20 * constants.scaleFactor
            url: images.map_pin_icon
        }
    }

    // Map view UI presentation at top
    MapView {
        id: mapView

        anchors.fill: parent

        Map {
            id: myMap

            BasemapDarkGrayCanvasVector{}

            onLoadStatusChanged: {
                if (loadStatus === Enums.LoadStatusLoaded) {
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
        // create graphic for Japan
        var pointJapan = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: 15529258.289,
                        y: 4478951.784,
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphicJapan = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: pointJapan
                    });

        // create graphic for UK
        var pointUK = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: -242452.379,
                        y: 7081479.723,
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphicUK = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: pointUK
                    });

        // create graphic for Turkey
        var pointTurkey = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: 3964641.658,
                        y: 4733334.214,
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphicTurkey = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: pointTurkey
                    });

        // create graphic for Greece
        var pointGreece = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: 2641975.320,
                        y: 4584740.631,
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphicGreece = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: pointGreece
                    });

        // create graphic for Dutch
        var pointDutch = ArcGISRuntimeEnvironment.createObject(
                    "Point", {
                        x: 549153.005,
                        y: 6864652.032,
                        spatialReference: SpatialReference.createWebMercator()
                    });

        var graphicDutch = ArcGISRuntimeEnvironment.createObject(
                    "Graphic", {
                        geometry: pointDutch
                    });

        graphicsOverlay.graphics.append(graphicJapan);
        graphicsOverlay.graphics.append(graphicUK);
        graphicsOverlay.graphics.append(graphicGreece);
        graphicsOverlay.graphics.append(graphicTurkey);
        graphicsOverlay.graphics.append(graphicDutch);
    }
}

import QtQuick 2.9

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Networking 1.0

Item {
    id: portal

    property url url: "https://www.arcgis.com"
    property string clientId: ""
    property string refreshToken: ""
    property string userAgent: ""

    property string username: "" //input by user or return by request for generating token
    property string password: ""

    property int expiryMode: 1 // 0 = expiryModeSignOut, 1 = expiryModeRenew
    property bool isBusy: false
    property bool signedIn: token > "" && portalInfo && userInfo

    property string token: ""
    property date expires

    property var portalInfo: null
    property var userInfo: null

    property string signInType: ""

    // keyname used for settings
    readonly property string settingsGroup : "Portal"

    //-----------------------------------------------------------------------------------
    // Quick access to some resources. This part should be customized as requirements by developers.

    property url userThumbnailUrl: userInfo && userInfo.thumbnail>""? url + "/sharing/rest/community/users/" + username + "/info/" + userInfo.thumbnail + "?token=" + token : ""
    property string userFullName: userInfo && userInfo.fullName > "" ? userInfo.fullName : (username > "" ? username : "")
    property var info: portalInfo
    property var user: userInfo
    property url portalUrl: url

    //-----------------------------------------------------------------------------------

    property Settings settings
    property SecureStorageManager secureStorageManager

    //-----------------------------------------------------------------------------------

    signal expired()
    signal error(var e)
    signal selfRequestDone()

    //-----------------------------------------------------------------------------------

    Component.onCompleted: {
        init();
    }

    function init(){
        userAgent = buildUserAgent(app);
    }

    //-----------------------------------------------------------------------------------

    function generateTokenFromCode(clientId, redirectUri, authorizationCode) {
        isBusy = true;
        if(clientId > "" && redirectUri > "" && authorizationCode > "") {
            portal.refreshToken = "";
            portal.clientId = clientId;

            var url = portal.url + "/sharing/rest/oauth2/token";
            var obj = {
                "grant_type": "authorization_code",
                "client_id": clientId,
                "code": authorizationCode,
                "redirect_uri": redirectUri
            }

            makeNetworkConnection(url, obj, function(response, params, errorCode){
                //TODO: logic after generating token
                if(response.hasOwnProperty("error")) {
                    error({
                              "errorType": "external",
                              "errorLocation": "generateTokenFromCode",
                              "error": response
                          });
                    isBusy = false;
                } else {
                    portal.token = response.access_token;
                    portal.refreshToken = response.refresh_token;
                    portal.expires = new Date(Date.now() + response.expires_in * 1000);
                    portal.username = response.username;
                    portal.signInType = "RefreshToken";

                    settings.setValue(settingsGroup + "/url", portal.url);
                    settings.setValue(settingsGroup + "/signInType", "RefreshToken");
                    settings.setValue(settingsGroup + "/username", portal.username);
                    secureStorageManager.clearContent(settingsGroup + "/password");
                    secureStorageManager.setContent(settingsGroup + "/refreshToken", portal.refreshToken);

                    timer.interval = portal.expires - Date.now() - 5000;
                    timer.start();

                    initSelfRequest();
                }
            }, "", "POST");

        } else {
            error({
                      "errorType": "internal",
                      "errorLocation": "generateTokenFromCode",
                      "error": "generateTokenFromCode::: parameters missing"
                  });
            isBusy = false;
        }
    }

    function generateTokenFromRefreshToken(clientId, refreshToken) {
        isBusy = true;
        if(clientId > "" && refreshToken > "") {
            portal.clientId = clientId;
            portal.refreshToken = refreshToken;

            var url = portal.url + "/sharing/rest/oauth2/token";
            var obj = {
                "grant_type": "refresh_token",
                "client_id": clientId,
                "refresh_token": refreshToken
            }

            makeNetworkConnection(url, obj, function(response) {
                if(response.hasOwnProperty("error")) {
                    error({
                              "errorType": "external",
                              "errorLocation": "generateTokenFromRefreshToken",
                              "error": response
                          });
                    isBusy = false;
                } else {
                    portal.token = response.access_token;
                    portal.expires = new Date(Date.now() + response.expires_in * 1000);
                    portal.username = response.username;
                    portal.signInType = "RefreshToken";

                    settings.setValue(settingsGroup + "/url", portal.url);
                    settings.setValue(settingsGroup + "/signInType", "RefreshToken");
                    settings.setValue(settingsGroup + "/username", portal.username);
                    secureStorageManager.clearContent(settingsGroup + "/password");
                    secureStorageManager.setContent(settingsGroup + "/refreshToken", portal.refreshToken);

                    timer.interval = portal.expires - Date.now() - 5000;
                    timer.start();

                    initSelfRequest();
                }
            }, "", "POST")

        } else {
            error({
                      "errorType": "internal",
                      "errorLocation": "generateTokenFromRefreshToken",
                      "error": "generateTokenFromRefreshToken::: parameters missing"
                  });
            isBusy = false;
        }
    }

    function generateTokenFromBuiltIn(username, password, errorCallback) {
        isBusy = true;

        // saved for refreshing token
        if(username > "") portal.username = username;
        if(password > "") portal.password = password;

        var url = portal.url + "/sharing/rest/generateToken";
        var obj = {
            "f": "json",
            "referer": portal.url,
            "expiration": 120
        }

        if(username > "") obj.username = username;
        if(password > "") obj.password = password;

        makeNetworkConnection(url, obj, function(response, errorCallback, errorCode){
            if(response.hasOwnProperty("token")) {
                portal.token = response.token;
                portal.expires = new Date(response.expires);
                portal.signInType = "BuiltIn";

                settings.setValue(settingsGroup + "/url", portal.url);
                settings.setValue(settingsGroup + "/signInType", "BuiltIn");
                settings.setValue(settingsGroup + "/username", portal.username);
                secureStorageManager.clearContent(settingsGroup + "/refreshToken");
                secureStorageManager.setContent(settingsGroup + "/password", portal.password);

                timer.interval = expires - Date.now() - 5000;
                timer.start();

                if(portal.token > "") initSelfRequest();
            } else {
                errorCallback();
                isBusy = false;
            }
        }, errorCallback, "POST", username, password);

    }

    function autoSignIn() {
        if (!settings) {
            return;
        }

        if (!secureStorageManager) {
            return;
        }

        signInType = settings.value(settingsGroup + "/signInType");
        url = settings.value(settingsGroup + "/url", portal.url);

        if(signInType === "BuiltIn") {
            username = settings.value(settingsGroup + "/username", "");
            password = secureStorageManager.getContent(settingsGroup + "/password");
            generateTokenFromBuiltIn(username, password);
        } else if(signInType === "RefreshToken") {
            refreshToken = secureStorageManager.getContent(settingsGroup + "/refreshToken");
            generateTokenFromRefreshToken(clientId, refreshToken);
        }
    }

    // force portal to renew the token
    function renew() {
        if(isBusy) {
            return;
        } else if(clientId > "" && refreshToken > "" && signInType === "RefreshToken") {
            generateTokenFromRefreshToken(clientId, refreshToken)
        } else if (clientId > "" && username > "" && password && signInType === "BuiltIn") {
            generateTokenFromBuiltIn(username, password);
        } else {
            signOut();
        }
    }

    // sign out the current account
    function signOut() {
        Networking.clearAccessCache();
        app.portalUrl = "https://www.arcgis.com";
        app.appSettings.setValue("portalUrl", app.portalUrl);
        portal.url = "https://www.arcgis.com";

        username = "";
        password = "";
        refreshToken = "";
        token = "";
        userInfo = null;
        portalInfo = null;

        settings.remove(settingsGroup + "/username");
        secureStorageManager.clearContent(settingsGroup + "/password");
        secureStorageManager.clearContent(settingsGroup + "/refreshToken");
        secureStorageManager.clearContent(settingsGroup + "/token");

        timer.stop();

        isBusy = false;
    }

    //-----------------------------------------------------------------------------------

    function initSelfRequest() {
        portalSelfRequest(function(response){
            portal.portalInfo = response;
            portal.username = response.user.username;

            userSelfRquest(response.user.username, function(response2) {
                portal.userInfo = response2;
                portal.isBusy = false;
                portal.selfRequestDone();
            });
        });
    }

    // get portal info
    function portalSelfRequest(callback) {
        var url = portal.url + "/sharing/rest/portals/self";
        var obj = {
            "f": "json",
        }

        if(portal.token > "") {
            obj.token = portal.token;
        }

        makeNetworkConnection(url, obj, callback, "", "POST");
    }

    function userSelfRquest(username, callback) {
        var url = portal.url + "/sharing/rest/community/users/" + username;
        var obj = {
            "f": "json",
        }

        if(portal.token > "") {
            obj.token = portal.token;
        }

        makeNetworkConnection(url, obj, callback, "", "POST");
    }

    //-----------------------------------------------------------------------------------

    Timer {
        id: timer

        onTriggered: {
            switch (expiryMode) {
            case 0:
                signOut();
                break;
            case 1:
                renew();
                break;
            default:
                expired(); // signal
            }
        }
    }

    //-----------------------------------------------------------------------------------

    function makeNetworkConnection(url, obj, callback, params, method, username, password) {
        Networking.clearAccessCache();

        if(typeof method === "undefined") method = "POST";

        var component = networkRequestComponent;
        var networkRequest = component.createObject(parent);
        networkRequest.url = url;
        networkRequest.method = method;
        networkRequest.callback = callback;
        networkRequest.params = params;
        networkRequest.headers.userAgent = userAgent;
        if(portal.username > "") networkRequest.user = portal.username;
        if(portal.password > "") networkRequest.password = portal.password;
        if(username > "") networkRequest.user = username;
        if(password > "") networkRequest.password = password;

        networkRequest.send(obj);
    }

    Component {
        id: networkRequestComponent

        NetworkRequest {
            property var callback
            property var params

            followRedirects: true
            ignoreSslErrors: true
            responseType: "json"
            method: "POST"

            onReadyStateChanged: {
                if (readyState == NetworkRequest.DONE){
                    if (errorCode === 0) {
                        callback(response, params, errorCode);
                    } else {
                        callback(response, params, errorCode);
                    }
                }
            }

            onError: {
                callback({}, params, -1);
            }
        }
    }

    //-----------------------------------------------------------------------------------
    // utility functions

    function getOSPrettyName(os){
        var niceName = "";
        switch(os) {
        case "osx":
        case "macos":
            niceName = "macOS";
            break;
        case "android":
            niceName = "Android";
            break;
        case "windows":
            niceName = "Windows";
            break;
        case "linux":
            niceName = "Linux";
            break;
        case "tvos":
            niceName = "tvOS";
            break;
        case "unix":
            niceName = "Unix Other";
            break;
        case "winrt":
            niceName = "WinRT / UWP";
            break;
        default:
            niceName = "Unknown OS";
            break;
        }
        return niceName;
    }

    function buildUserAgent(app) {
        var appName = Qt.application.name > "" ? Qt.application.name : "_appName";
        var appVersion = Qt.application.version > "" ? Qt.application.version : "_appVersion";
        var udid = settings.value("udid", "_udidNotAvailable");

        if (app) {
            var deployment = app.info.value("deployment");
            if (!deployment || typeof deployment !== 'object') {
                deployment = {};
            }

            appName = deployment.shortcutName > ""
                    ? deployment.shortcutName
                    : app.info.title;

            appVersion = app.info.version;
        }

        // SDK
        var sdkName = "AppFramework";
        var sdkVersion = AppFramework.version;

        // OS
        var osPrettyName = getOSPrettyName(Qt.platform.os);
        var osVersion = AppFramework.osVersion > "" ? AppFramework.osVersion : "_osVersion";
        var osLocale = Qt.locale().name > "" ? Qt.locale().name : "_unknownLocale";
        var cpuArchitecture = AppFramework.currentCpuArchitecture > "" ? AppFramework.currentCpuArchitecture : "_cpuArchitecture";

        // App
        var qtVersion = "Qt %1".arg(AppFramework.qtVersion);
        var buildAbi = AppFramework.buildAbi > "" ? AppFramework.buildAbi : "_buildAbi";
        var kernalType = AppFramework.kernelType > "" ? AppFramework.kernelType : "_kernalType";
        var kernalVersion = AppFramework.kernelVersion > "" ? AppFramework.kernelVersion : "_kernalVersion"
        var osDisplayName = AppFramework.osDisplayName > "" ? AppFramework.osDisplayName : "_osDisplayName";

        var userAgent = "%1/%2 (%3 %4; %5; %6; %7) %8/%9 (%10; %11; %12) %13/%14"
        .arg(sdkName)
        .arg(sdkVersion)
        .arg(osPrettyName)
        .arg(osVersion)
        .arg(osLocale)
        .arg(cpuArchitecture)
        .arg(udid)
        .arg(appName)
        .arg(appVersion)
        .arg(qtVersion)
        .arg(buildAbi)
        .arg(osDisplayName)
        .arg(kernalType)
        .arg(kernalVersion);

        return userAgent;
    }
}

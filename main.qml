import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import Qt.labs.platform 1.0

import "FontAwesome.js" as FA
import "config.js" as Config

ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640
    title: qsTr("beacon-client")

    Material.primary: "#05070d"
    Material.foreground: "#05070d"
    Material.accent: "#41cd52"

    FontLoader { id: fontAwesome; source: "qrc:///FontAwesome.otf" }

    QtObject {
        id: internal
        property string baseServer: "http://" + Config.hostname + ":" + Config.port
    }

    header: ToolBar {
        width: parent.width
        RowLayout {
            anchors.fill: parent
            AwesomeToolButton {
                text: FA.icons["bars"]
                onClicked: drawer.open()
            }
            Label {
                text: "beacon-client"
                font.bold: true
                color: "white"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            AwesomeToolButton {
                text: FA.icons["info"]
            }
        }
    }

    Drawer {
        id: drawer
        width: parent.width*2/3
        height: parent.height
        Column {
            anchors.fill: parent
            Rectangle {
                width: drawer.width
                height: appWindow.height / 3
                color: Material.primaryColor

                Label {
                    width: drawer.width / 3 * 2
                    height: contentHeight
                    anchors { left: parent.left; leftMargin: 13; bottom: parent.bottom; bottomMargin: 5 }
                    text: "beacon-client"
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: width
                    font.family: "Roboto"
                    color: "white"
                }
            }
            ListView {
                width: parent.width
                height: 2 * (appWindow.height / 3)
                model: contents
                clip: true
                delegate: ItemDelegate {
                    width: parent.width
                    text: "         " + modelData.menuName

                    AwesomeToolButton {
                        text: FA.icons[modelData.icon]
                        enabled: false
                    }
                    onClicked: {
                        tabBar.currentIndex = index
                        drawer.close()
                    }
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        
        Repeater {
            model: contents
            Loader {
                source: (Qt.platform.os === "android") ?
                        "assets:/plugins/" + modelData.pluginName + "/" + modelData.mainPage
                        :
                        "file://" + modelData.pluginName + "/" + modelData.mainPage
            }
        }
    }

    footer: TabBar {
        id: tabBar
        width: parent.width
        currentIndex: swipeView.currentIndex
        Repeater {
            model: contents
            TabButton { text: modelData.menuName }
        }
    }
}

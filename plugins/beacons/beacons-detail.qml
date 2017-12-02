import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    property var model
    property StackView stackView

    QtObject {
        id: pluginInternal
        property int padding: 10
    }

    Column {
        width: parent.width
        padding: pluginInternal.padding
        spacing: 15
        GroupBox {
            title: "Macaddr"
            width: parent.width-2*pluginInternal.padding
            Label {
                text: model["macaddr"]
            }
        }
        GroupBox {
            title: "Label"
            width: parent.width-2*pluginInternal.padding
            Label {
                text: model["label"]
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: stackView.pop()
    }
}

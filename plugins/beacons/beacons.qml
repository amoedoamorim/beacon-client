import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "../../"

Item {
    JSONListModel { id: beaconsModel; source: internal.baseServer + "/beacons" }

    MyStackView {
        anchors.fill: parent
        model: beaconsModel.json
        itemHead: contents[index].itemHead
        itensPage: "plugins/beacons/beacons-detail.qml"
        icon: contents[index].icon
    }

    Settings {
        property alias beaconsModel: beaconsModel.json
    }

    Component.onCompleted: {
        if (beaconsModel.json === undefined)
            beaconsModel.load()
    }
}

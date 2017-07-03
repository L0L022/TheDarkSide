import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: item1

    ColumnLayout {
        anchors.rightMargin: 50
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: label
            text: qsTr("Installation...")
            font.pointSize: 30
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        ProgressBar {
            id: progressBar
            height: 50
            indeterminate: true
            Layout.fillWidth: true
            value: 0.5
        }
    }

}

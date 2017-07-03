import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import TDS 1.0

Item {
    id: item1

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        RadioButton {
            id: radioButton
            text: qsTr("Standard")
            checked: stagesSystem.currentStage.mode === InstallModeStage.Standard
            onClicked: stagesSystem.currentStage.mode = InstallModeStage.Standard
        }

        RadioButton {
            id: radioButton1
            text: qsTr("Customisée")
            checked: stagesSystem.currentStage.mode === InstallModeStage.Customize
            onClicked: stagesSystem.currentStage.mode = InstallModeStage.Customize
        }
    }

    Button {
        id: button
        x: 424
        y: 357
        text: qsTr("Valider")
        onClicked: stagesSystem.next()
    }
}

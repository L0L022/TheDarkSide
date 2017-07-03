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
            text: qsTr("Changer les modules")
            checked: stagesSystem.currentStage.action === ModifyInstallStage.ChangeModules
            onClicked: stagesSystem.currentStage.action = ModifyInstallStage.ChangeModules
        }

        RadioButton {
            id: radioButton1
            text: qsTr("Réinstaller")
            checked: stagesSystem.currentStage.action === ModifyInstallStage.Reinstall
            onClicked: stagesSystem.currentStage.action = ModifyInstallStage.Reinstall
        }

        RadioButton {
            id: radioButton2
            text: qsTr("Désinstaller")
            checked: stagesSystem.currentStage.action === ModifyInstallStage.Uninstall
            onClicked: stagesSystem.currentStage.action = ModifyInstallStage.Uninstall
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

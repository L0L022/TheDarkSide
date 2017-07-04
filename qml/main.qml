import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import TDS 1.0

ApplicationWindow {
    id: window
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    width: 640
    height: 480
    title: qsTr("Hello World")
    flags: Qt.Window | Qt.FramelessWindowHint

    MouseArea {
        anchors.fill: parent
        property var previousPos
        onPressed:{
            previousPos = Qt.point(mouseX, mouseY)
            cursorShape = Qt.SizeAllCursor
        }
        onPositionChanged: {
            window.x = window.x + mouse.x - previousPos.x
            window.y = window.y + mouse.y - previousPos.y
        }
        onReleased: cursorShape = Qt.ArrowCursor
    }

    StackView {
        id: swipeView
        anchors.fill: parent
        Component.onCompleted: updateView()

        function updateView() {
            console.log(stagesSystem.currentStage)
            if (stagesSystem.currentStage) {
                switch (stagesSystem.currentStage.stage) {
                default:
                    break;
                case AbstractStage.Welcome:
                    push("Welcome.qml")
                    break;
                case AbstractStage.ModifyInstall:
                    push("ModifyInstall.qml")
                    break;
                case AbstractStage.ConfigModules:
                    push("ConfigModules.qml")
                    break;
                case AbstractStage.InstallMode:
                    push("InstallMode.qml")
                    break;
                case AbstractStage.Install:
                    push("Install.qml")
                    break;
                }
            }
        }
    }

    Connections {
        target: stagesSystem
        onCurrentStageChanged: swipeView.updateView()
    }

    Button {
        text: "❌"
        anchors.rightMargin: 7
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked: close()
        flat: true
    }
}

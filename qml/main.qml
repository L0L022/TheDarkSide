import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import TDS 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    flags: Qt.Window | Qt.FramelessWindowHint

    Material.theme: Material.Dark

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
                case AbstractStage.Init:
                    break;
                case AbstractStage.Welcome:
                    push("Welcome.qml")
                    break;
                case AbstractStage.ModifyInstall:
                    push("ModifInstall.qml")
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
        text: "<font color=\"white\">❌</font>"
        anchors.rightMargin: 7
        anchors.top: parent.top
        anchors.topMargin: 7
        anchors.right: parent.right
        onClicked: close()
        flat: true
    }
}

import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import TDS 1.0

Item {
    id: item1

    ListView {
        id: listView
        anchors.right: columnLayout.left
        anchors.rightMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 415
        Layout.preferredWidth: 318

        model: stagesSystem.currentStage.modules()

        delegate: MouseArea {
            height: rowLayout.implicitHeight
            width: listView.width - scrollBar.width - listView.anchors.rightMargin

            hoverEnabled: true
            onEntered: {
                moduleName.text = nameRole
                moduleDescription.text = descriptionRole
            }

            ItemDelegate {
                anchors.fill: parent
                visible: hasSubModulesRole
            }

            RowLayout {
                id: rowLayout
                width: parent.width

                CheckBox {
                    checked: moduleRole.isEnabled
                    onCheckedChanged: moduleRole.isEnabled = checked
                }

                Label {
                    Layout.fillWidth: true
                    text: nameRole
                }

                Label {
                    id: subModulesButton
                    visible: hasSubModulesRole
                    text: "→"
                    Layout.rightMargin: 20

                    SequentialAnimation {
                        running: true

                        PropertyAction { target: subModulesButton; properties: "opacity"; value: 0 }
                        PauseAnimation {
                            duration: index * 100 + 400
                        }
                        NumberAnimation { target: subModulesButton; property: "opacity"; to: 1; duration: 300 }
                    }
                }
            }
        }

        header: Item {
            width: listView.width
            height: visible ? backButton.implicitHeight : 0
            visible: false

            Button {
                id: backButton
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                text: "←"
            }

            Label {
                anchors.centerIn: parent
                text: "Liste pour montrer"
            }
        }

        section.property: "categoryRole"
        section.delegate: Item {
            height: 55
            Label {
                anchors.fill: parent
                anchors.topMargin: 10
                text: section
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
            }
        }

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            policy: ScrollBar.AlwaysOn
        }

        populate: Transition {
            id: popTrans
            SequentialAnimation {
                PropertyAction { properties: "x"; value: -width }
                PauseAnimation {
                    duration: (popTrans.ViewTransition.index -
                               popTrans.ViewTransition.targetIndexes[0]) * 100
                }
                NumberAnimation { properties: "x"; duration: 500; easing.type: Easing.OutBack }
            }
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.rightMargin: 6
        anchors.bottomMargin: 6
        anchors.topMargin: 55

        Frame {
            id: frame
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            Layout.preferredWidth: 200

            ColumnLayout {
                anchors.fill: parent

                Label {
                    id: moduleName
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    fontSizeMode: Text.Fit
                    font.pointSize: 18
                }

                Label {
                    id: moduleDescription
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }

        Button {
            id: button
            text: qsTr("Valider")
            Layout.fillWidth: true
            onClicked: stagesSystem.next()
        }
    }
}

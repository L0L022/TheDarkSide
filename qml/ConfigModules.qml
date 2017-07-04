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
        anchors.leftMargin: 6
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 415
        Layout.preferredWidth: 318

        model: ListModel {
            ListElement { name: "BOOST"; selected: false; section: "Lib"; hasSubModules: true }
            ListElement { name: "Qt"; selected: false; section: "Lib"; hasSubModules: false }
            ListElement { name: "EntityX"; selected: false; section: "Lib"; hasSubModules: false }

            ListElement { name: "XFCE"; selected: true; section: "Desktop"; hasSubModules: true }
            ListElement { name: "KDE"; selected: false; section: "Desktop"; hasSubModules: false }
            ListElement { name: "GNOME"; selected: false; section: "Desktop"; hasSubModules: false }

            ListElement { name: "Atom"; selected: true; section: "App"; hasSubModules: false }
            ListElement { name: "Blender"; selected: false; section: "App"; hasSubModules: false }
            ListElement { name: "Firefox"; selected: false; section: "App"; hasSubModules: false }
            ListElement { name: "Spotify"; selected: true; section: "App"; hasSubModules: false }
            ListElement { name: "Codeblock"; selected: false; section: "App"; hasSubModules: false }
            ListElement { name: "Chromium"; selected: true; section: "App"; hasSubModules: false }
        }

        delegate: RowLayout {
            width: listView.width - scrollBar.width - listView.anchors.rightMargin

            CheckBox {
                checked: selected
            }

            Label {
                Layout.fillWidth: true
                text: name
            }

            Button {
                id: subModulesButton
                visible: hasSubModules
                text: "→"

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

        header: Item {
            width: listView.width
            height: visible ? backButton.implicitHeight : 0
//            visible: false

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

        section.property: "section"
        section.delegate: Label {
            text: section
            font.pointSize: 13
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
                    id: label
                    text: qsTr("Super Module")
                    fontSizeMode: Text.Fit
                    font.pointSize: 18
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Label {
                    id: label1
                    text: qsTr("Blablablabla")
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

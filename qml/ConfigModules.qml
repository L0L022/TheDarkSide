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
            ListElement { name: "BOOST"; selected: false }
            ListElement { name: "Qt"; selected: false }
            ListElement { name: "XFCE"; selected: true }
            ListElement { name: "KDE"; selected: false }
            ListElement { name: "Atom"; selected: true }
            ListElement { name: "Blender"; selected: false }
            ListElement { name: "Firefox"; selected: false }
            ListElement { name: "Spotify"; selected: true }
            ListElement { name: "Codeblock"; selected: false }
            ListElement { name: "Chromium"; selected: true }
            ListElement { name: "EntityX"; selected: false }
            ListElement { name: "GNOME"; selected: false }
        }

        delegate: RowLayout {
            CheckBox {
                checked: selected
            }

            Label {
                text: name
            }
        }


        ScrollBar.vertical: ScrollBar {
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
        x: 396
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

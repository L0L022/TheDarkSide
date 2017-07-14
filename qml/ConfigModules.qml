import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import TDS 1.0

Item {
    id: item1

    QSortFilterProxyModel {
        id: modules
        sourceModel: stagesSystem.currentStage.modules()
        sortRole: ModuleModel.CategoryRole
        filterRole: ModuleModel.DirectDependencyRole
        filterRegExp: /^$/
    }

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

        property var selectedModule: null
        property var modulesStack: []

        function updateSelectedModule() {
            if (modulesStack.length > 0)
                selectedModule = modulesStack[modulesStack.length - 1]
            else
                selectedModule = null
        }

        function selectModule(module) {
            modulesStack.push(module)
            updateSelectedModule()
            modules.filterRegExp = new RegExp('^'+selectedModule.id+'$')
        }

        function goBack() {
            modulesStack.pop()
            updateSelectedModule()
            if (selectedModule === null)
                modules.filterRegExp = /^$/
            else
                modules.filterRegExp = new RegExp('^'+ selectedModule.directDependency +'$')
        }

        model: modules

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
                onClicked: listView.selectModule({"id": idRole, "name": nameRole, "directDependency": directDependencyRole})
            }

            RowLayout {
                id: rowLayout
                width: parent.width

                CheckBox {
                    checked: isEnabledRole
//                    onCheckedChanged: moduleRole.isEnabled = checked
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
            visible: listView.selectedModule !== null

            Button {
                id: backButton
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                text: "←"
                onClicked: listView.goBack()
            }

            Label {
                anchors.centerIn: parent
                text: listView.selectedModule === null ? "" : listView.selectedModule.name
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

        add: popTrans
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

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick 6.5
import QtQuick.Controls 6.5
import ToDoApp
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#000000"
    property bool isDialogOpen: false


    Text {
        id: text1
        color: "#ffffff"
        text: qsTr("To Do")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 27
        horizontalAlignment: Text.AlignHCenter
        font.italic: false
        font.bold: true
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    Button {
        id: addToDoButton
        y: 558
        text: qsTr("ADD TODO")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10

        Connections {
            target: addToDoButton
            onClicked: rectangle.isDialogOpen = !rectangle.isDialogOpen
        }
    }


    Rectangle {
        id: addToDoDialog
        x: 10
        y: 571
        width: 380
        height: 157
        opacity: rectangle.isDialogOpen
        color: "#323232"
        radius: 30

        TextField {
            id: toDoTextInput
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 25
            placeholderText: qsTr("My To Do")
        }

        RowLayout {
            y: 97
            height: 52
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            spacing: 50
            Button {
                id: cancelButton
                text: qsTr("CANCEL")
                Layout.fillWidth: true

                Connections {
                    target: cancelButton
                    onClicked: toDoTextInput.text = ""
                }
            }

            Button {
                id: addButton
                text: qsTr("ADD")
                Layout.fillWidth: true

                Connections {
                    target: addButton
                    // The logic to not add empty toDoItem
                    onClicked: {
                        if(toDoTextInput.text != "") {
                            myListModel.append(myListModel.createListElement())
                        // Also need to close the addToDoDialog
                        rectangle.isDialogOpen = false
                        }
                    }

                }
            }
        }
    }


    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 20
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 100
        anchors.topMargin: 50

        Repeater {
            id: repeater
            anchors.fill: parent

            // ListModel needed to add toDoItems
            model: ListModel {
                id: myListModel
                ListElement {
                    name: "My To Do"
                }

                function createListElement() {
                    return {
                        "name": toDoTextInput.text
                    }
                }
            }


            Rectangle {
                id: toDoItem
                x: 7
                y: 7
                width: 367
                height: 59
                color: "#494949"
                radius: 10

                CheckBox {
                    id: checkBox
                    text: name // to reflect the name as ListElement
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.pointSize: 22
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                }
            }
        }
    }

    Connections {
        target: rectangle
        onClicked: console.log("clicked")
    }

    states: [
        State {
            name: "clicked"
            when: addToDoButton.checked
        }
    ]
}

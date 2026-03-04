import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// Cloak
Item {
    id: cloak
    property var barHeight
    property color colBg
    property color colText
    Rectangle {
        id: cloakShape
        visible: true
        color: colBg
        width: 120
        height: barHeight / 1.5
        radius: 10
        anchors.centerIn: parent
        Text {
            id: cloakText
            color: colText
            font { pixelSize: 13 ; bold: true }
            anchors.centerIn: parent
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: cloakText.text = Qt.formatDateTime(new Date(), "hh:mm AP d MMM")
            }
        }
    }
}
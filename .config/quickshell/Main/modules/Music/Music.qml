import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// Music
Item {
    id: music
    property var barHeight
    property color colText
    property color colPill
    anchors.centerIn: parent
    Rectangle {
        id: musicShape
        visible: true
        color: colPill
        width: textMusic.contentWidth + 25
        height: barHeight / 1.5
        radius: 10
        anchors.centerIn: parent

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Text {
            id: textMusic
            color: colText
            font { pixelSize: 13 ; bold: true }
            anchors.centerIn: parent
 
            opacity: 1
            Behavior on opacity { NumberAnimation { duration: 150 } }
            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            

            Process {
                id: musicProcess
                running: true
                command: ["playerctl", "-p", "spotify", "metadata", "--format", "{{artist}} | {{title}}"]
                stdout: StdioCollector {
                    onStreamFinished: textMusic.text = this.text
                }
            }
            Timer {
                interval: 500
                running: true
                repeat: true
                onTriggered: {
                    if (!musicProcess.running) musicProcess.running = true
                    if (textMusic.text == "") musicShape.visible = false
                    else musicShape.visible = true
                }
            }
        }
    }
}
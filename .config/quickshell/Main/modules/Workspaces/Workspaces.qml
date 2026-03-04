import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

// Workspaces
Repeater {
    property var barHeight
    property color colPill
    property color colActive
    property color colUnActive
    property color colNotExist
    model: 5
    Rectangle{
        id: pill
        color: workText.isActive ? colNotExist : colPill
        Layout.preferredWidth: workText.isActive ? 65 : 45 
        Layout.preferredHeight: barHeight / 1.5
        radius: workText.isActive ? 4 : 10 

        Behavior on Layout.preferredWidth {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }
        Behavior on radius {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    
        MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        Text {
            id: workText
            anchors.centerIn: parent
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            text: index + 1
            color: isActive ? colActive : (ws ? colUnActive : colNotExist)
            font { pixelSize: 14; bold: true }      
        }
    }
}
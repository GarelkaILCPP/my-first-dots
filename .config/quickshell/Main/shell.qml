import "modules/Cloak"
import "modules/Workspaces"
import "modules/Music"
import "services/Wallust" 

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: root
    anchors.top: true
    anchors.bottom: false
    anchors.left: true
    anchors.right: true
    
    // Visual stuff
    implicitHeight: 30
    color: '#002b2b2b'
    
    RowLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: root.implicitHeight / 6
        spacing: 4

        // Workspaces
        Workspaces {
            barHeight: root.implicitHeight
            colPill: WallustColors.colors.color1     
            colActive: WallustColors.colors.color7   
            colUnActive: WallustColors.colors.color6 
            colNotExist: WallustColors.colors.color5 
        }

        Item { Layout.fillWidth: true }
        
        // Music
        Music {
            barHeight: root.implicitHeight
            colText: WallustColors.colors.color7
            colPill: WallustColors.colors.color1
        }

        Cloak {
            barHeight: root.implicitHeight
            colText: WallustColors.colors.color7
            colBg: WallustColors.colors.color1
        }
        
        Item {
            Layout.rightMargin: root.implicitHeight / 0.55
        }
    }
}
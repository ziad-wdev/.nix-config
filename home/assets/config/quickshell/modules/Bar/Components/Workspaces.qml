import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
  spacing: 8

  Repeater {
    model: 5

    delegate: Rectangle {
      id: button
      property var wsId: index + 1
      property bool isActive: Hyprland.focusedWorkspace?.id === wsId
      property bool isOccupied: Hyprland.workspaces.values.some(w => w.id === wsId)

      implicitWidth: isActive ? 30 : 20
      implicitHeight: 6
      radius: root.radius
      color: isActive ? colors.primary : isOccupied ? colors.tertiary : colors.alphaPrimary1

      MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsId} })`)
      }

      states: State {
        name: "hovered"
        when: mouseArea.containsMouse
        PropertyChanges {
          target: button
          color: colors.lighterPrimary
        }
      }

      Behavior on color {
        ColorAnimation {
          duration: 150
        }
      }
      Behavior on width {
        NumberAnimation {
          duration: 150
        }
      }
    }
  }
}

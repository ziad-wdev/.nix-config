import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
  spacing: 8

  Repeater {
    model: ["I", "II", "III", "IV", "V"]

    delegate: Rectangle {
      id: button

      property color baseColor: isActive ? colors.primary : isOccupied ? colors.tertiary : Qt.alpha(colors.primary, 0.1)
      property bool isActive: Hyprland.focusedWorkspace?.id === wsId
      property bool isOccupied: Hyprland.workspaces.values.some(w => w.id === wsId)
      property var wsId: index + 1

      color: baseColor
      implicitHeight: 6
      implicitWidth: isActive ? 30 : 20
      radius: root.radius

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

      MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        states: State {
          name: "hovered"
          when: mouseArea.containsMouse

          PropertyChanges {
            color: Qt.lighter(baseColor, 1.2)
            target: button
          }
        }

        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsId} })`)
      }
    }
  }
}

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
  spacing: 6

  Repeater {
    model: ["I", "II", "III", "IV", "V"]

    delegate: Rectangle {
      id: button

      readonly property color baseColor: isActive ? theme.colors.primary2 : isOccupied ? theme.colors.tertiary2 : Qt.alpha(theme.colors.primary2, 0.1)
      readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsId
      readonly property bool isOccupied: Hyprland.workspaces.values.some(w => w.id === wsId)
      readonly property var wsId: index + 1

      Layout.preferredHeight: 6
      Layout.preferredWidth: isActive ? 30 : 20
      color: baseColor
      radius: theme.radius

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

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
  spacing: 12

  Text {
    Timer {
      interval: 1000
      running: true
      repeat: true
      triggeredOnStart: true
      onTriggered: parent.text = new Date().toLocaleTimeString(Locale.Default, {
        hour: '2-digit',
        minute: '2-digit'
      })
    }

    text: "00:00 AM"
    color: colors.primary
  }

  Row {
    spacing: 8

    Repeater {
      model: 5

      delegate: Rectangle {
        id: wsButton
        property var wsId: index + 1
        property bool isActive: Hyprland.focusedWorkspace?.id === wsId
        property bool isOccupied: Hyprland.workspaces.values.some(w => w.id === wsId)
        width: isActive ? 30 : 20
        height: 6
        radius: root.radius

        property color baseColor: isActive ? colors.primary : isOccupied ? colors.tertiary : Qt.alpha(colors.primary, 0.1)
        color: baseColor

        states: State {
          name: "hovered"
          when: mouseArea.containsMouse
          PropertyChanges {
            target: wsButton
            color: Qt.lighter(baseColor, 1.3)
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

        MouseArea {
          id: mouseArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsId} })`)
        }
      }
    }
  }
}

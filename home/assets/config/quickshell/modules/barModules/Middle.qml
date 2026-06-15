import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
  spacing: 12

  Text {
    Timer {
      interval: 1000; running: true; repeat: true; triggeredOnStart: true
      onTriggered: parent.text = new Date().toLocaleTimeString(Locale.Default, { hour: '2-digit', minute: '2-digit' })
    }

    text: "00:00 AM"
    color: colors.primary
    font.pixelSize: 16
  }

  Row {
    spacing: 8

    Repeater {
      model: 5

      delegate: Rectangle {
        property var wsId: index + 1
        property bool isActive: Hyprland.focusedWorkspace?.id === wsId
        property var notEmpty: Hyprland.workspaces.values.find( w => w.id === wsId )
        width: isActive ? 30 : 20
        height: 6
        radius: 20
        color: isActive
          ? colors.primary
          : notEmpty
            ? colors.tertiary
            : colors.surface_container

        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on width { NumberAnimation { duration: 150 } }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsId} })`)
        }
      }
    }
  }
}

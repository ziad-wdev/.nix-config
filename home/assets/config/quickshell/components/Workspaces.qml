import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
  id: root

  readonly property color bg: theme.colors.bg1
  readonly property color bgActive: Qt.alpha(theme.colors.primary2, 0.1)
  readonly property color bgOccupied: Qt.alpha(theme.colors.tertiary2, 0.1)
  readonly property color textColor: theme.colors.bg4
  readonly property color textColorActive: theme.colors.primary2
  readonly property color textColorOccupied: theme.colors.tertiary2
  readonly property int fontSize: theme.fontSizeSmall
  readonly property int padding: 6
  readonly property int radius: 2

  spacing: 6

  Repeater {
    model: 10

    delegate: Rectangle {
      readonly property bool isActive: Hyprland.focusedWorkspace?.id === index + 1
      readonly property bool isOccupied: Hyprland.workspaces.values.some(w => w.id === index + 1)
      readonly property bool shouldShow: index + 1 <= 6 || isActive || isOccupied

      Layout.preferredHeight: root.fontSize + root.padding
      Layout.preferredWidth: root.fontSize + root.padding
      radius: root.radius
      color: isActive ? root.bgActive : isOccupied ? root.bgOccupied : root.bg
      opacity: shouldShow ? 1 : 0
      scale: shouldShow ? 1 : 0
      visible: opacity > 0.6

      Behavior on opacity {
        NumberAnimation {
          duration: theme.duration
          easing.type: theme.easingOut
        }
      }
      Behavior on scale {
        NumberAnimation {
          duration: theme.duration * 2
          easing.type: theme.popOut
        }
      }

      MouseArea {
        anchors.fill: parent

        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
      }

      Text {
        anchors.centerIn: parent
        color: parent.isActive ? root.textColorActive : parent.isOccupied ? root.textColorOccupied : root.textColor
        font.pixelSize: root.fontSize
        text: index + 1

        Behavior on color {
          ColorAnimation {
            duration: theme.duration
            easing.type: theme.easingOut
          }
        }
      }
    }
  }
}

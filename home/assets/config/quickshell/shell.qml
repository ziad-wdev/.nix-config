//@ pragma ShellId MyDesktopShell
import ~/.local/share/themes
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  QuickShell {
    id: colors
  }

  Variants {
    model: Quickshell.screens

    Scope {
      property var modelData

      PanelWindow {
        screen: modelData
        anchors.top: true
        anchors.left: true
        anchors.right: true
        height: 40

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "quickshell:bar"

        Rectangle {
          anchors.fill: parent
          color: colors.background

          Text {
            anchors.centerIn: parent
            text: "Hello from Quickshell!"
            color: colors.primary
            font.pixelSize: 16
          }
        }
      }
    }
  }
}

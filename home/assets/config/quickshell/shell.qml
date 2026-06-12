//@ pragma ShellId MyDesktopShell
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
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
          color: "#1a1b26"

          Text {
            anchors.centerIn: parent
            text: "Hello from Quickshell!"
            color: "#c0caf5"
            font.pixelSize: 16
          }
        }
      }
    }
  }
}

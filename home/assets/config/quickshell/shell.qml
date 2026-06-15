//@ pragma ShellId MyDesktopShell
import "./modules"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  id: root
  readonly property int radius: 12
  readonly property int padding: 16

  Colors {
    id: colors
  }

  Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
      screen: modelData
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }
      height: 32

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "quickshell:bar"

      TopBar {
        anchors.fill: parent
      }
    }
  }
}

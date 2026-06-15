//@ pragma ShellId MyDesktopShell
import "./modules/PolkitAgent"
import "./modules/Bar"
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

  // PolkitAgent {}

  Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
      property var modelData
      screen: modelData
      anchors {
        top: true
        left: true
        right: true
      }
      color: "transparent"
      implicitHeight: 32

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "quickshell:bar"

      Bar {}
    }
  }
}

//@ pragma ShellId MyDesktopShell
import "./modules/PolkitAgent"
import "./modules/Bar"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  id: root

  readonly property int padding: 16
  readonly property int radius: 12

  Colors {
    id: colors
  }
  PolkitAgent {
  }
  Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
      property var modelData

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "quickshell:bar"
      color: "transparent"
      implicitHeight: 32
      screen: modelData

      anchors {
        left: true
        right: true
        top: true
      }
      Bar {
      }
    }
  }
}

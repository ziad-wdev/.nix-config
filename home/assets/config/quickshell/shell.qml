//@ pragma ShellId MyQuickshell
import "./Icons"
import "./Modules/PolkitAgent"
import "./Modules/Bar"
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
  Icons {
    id: icons
  }
  PolkitAgent {
  }
  Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
      property var modelData

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "quickshell:bar"
      anchors.left: true
      anchors.right: true
      anchors.top: true
      color: "transparent"
      implicitHeight: 32
      screen: modelData

      Bar {
      }
    }
  }
}

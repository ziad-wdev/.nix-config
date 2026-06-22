// @ pragma ShellId MyQuickshell
import "./Theme"
import "./Modules/Bar"
import "./Modules/PolkitAgent"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  id: root

  readonly property int fontSize: 16
  readonly property int padding: 16
  readonly property int radius: 12

  Theme {
    id: theme
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
      implicitHeight: root.fontSize + root.padding * 1.25
      screen: modelData

      Bar {
      }
    }
  }
}

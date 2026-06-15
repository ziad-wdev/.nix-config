//@ pragma ShellId MyDesktopShell
import "./modules"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  id: root
  Colors {
    id: colors
  }
  readonly property int radius: 16
  readonly property int padding: 16

  Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
      screen: modelData
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

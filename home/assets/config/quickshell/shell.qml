//@ pragma ShellId MyDesktopShell
import "./modules"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  id: root
  readonly property int radius: 16
  readonly property int padding: 16

  Colors {
    id: colors
  }

  Variants {
    model: Quickshell.screens

    Scope {
      property var modelData

      PanelWindow {
        screen: modelData
        anchors.top: true
        margins.top: 8
        color: "transparent"
        width: modelData.width * (40/100)
        height: 40

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "quickshell:bar"

        TopBar { anchors.fill: parent }
      }
    }
  }
}

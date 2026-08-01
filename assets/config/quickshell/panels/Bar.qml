import "../components"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: root

  readonly property int padding: 16
  readonly property int spacing: 16

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "quickshell:bar"
  anchors.left: true
  anchors.right: true
  anchors.top: true
  implicitHeight: 32
  color: theme.colors.bg0

  RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: root.padding
    height: parent.height
    spacing: root.spacing

    Workspaces {}
  }

  RowLayout {
    anchors.centerIn: parent
    height: parent.height
    spacing: root.spacing

    Clock {}
  }

  RowLayout {
    anchors.right: parent.right
    anchors.rightMargin: root.padding
    height: parent.height
    spacing: root.spacing

    Volume {}

    Network {}

    Battery {}
  }
}

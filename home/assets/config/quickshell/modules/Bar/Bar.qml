import "./Components"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "quickshell:bar"
  anchors.left: true
  anchors.right: true
  anchors.top: true
  color: theme.colors.bg0
  implicitHeight: theme.fontSizeSmall + theme.padding * 1.25

  // Left
  RowLayout {
    id: barLeft

    anchors.left: parent.left
    anchors.leftMargin: theme.padding
    height: parent.height
    spacing: theme.barInnerSpacing

    Workspaces {
    }
  }

  // Center
  RowLayout {
    id: barCenter

    anchors.centerIn: parent
    height: parent.height
    spacing: theme.barInnerSpacing

    Clock {
    }
  }

  // Right
  RowLayout {
    id: barRight

    anchors.right: parent.right
    anchors.rightMargin: theme.padding
    height: parent.height
    spacing: theme.barInnerSpacing

    Network {
    }
    Battery {
    }
  }
}

import "./Components"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  id: bar

  readonly property int spacing: root.padding

  anchors.fill: parent
  color: theme.colors.bg0

  RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: root.padding
    anchors.verticalCenter: parent.verticalCenter
    spacing: bar.spacing

    Workspaces {
    }
  }
  RowLayout {
    anchors.centerIn: parent
    spacing: bar.spacing

    Clock {
    }
  }
  RowLayout {
    anchors.right: parent.right
    anchors.rightMargin: root.padding
    anchors.verticalCenter: parent.verticalCenter
    spacing: bar.spacing

    Network {
    }
    Battery {
    }
  }
}

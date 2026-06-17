import "./Components"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  id: bar

  readonly property int spacing: 12

  anchors.fill: parent
  color: colors.base00

  RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: root.padding
    anchors.verticalCenter: parent.verticalCenter
    spacing: bar.spacing
  }
  RowLayout {
    anchors.centerIn: parent
    spacing: bar.spacing

    Clock {
    }
    Workspaces {
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

import "./barModules"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  color: colors.surface_container_lowest
  radius: root.radius

  RowLayout {
    anchors.fill: parent

    Left {
      Layout.alignment: Qt.AlignLeft;
      Layout.leftMargin: root.padding
    }
    Middle {
      Layout.alignment: Qt.AlignCenter;
      Layout.leftMargin: root.padding;
      Layout.rightMargin: root.padding
    }
    Right {
      Layout.alignment: Qt.AlignRight;
      Layout.rightMargin: root.padding
    }
  }
}

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

RowLayout {
  id: root

  readonly property int connectivity: Networking.connectivity

  spacing: 6

  Text {
    color: theme.colors.red2
    font.pixelSize: theme.fontSizeSmall
    text: root.network
  }
}

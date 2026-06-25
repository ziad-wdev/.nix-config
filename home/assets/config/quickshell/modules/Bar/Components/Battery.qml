import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower

RowLayout {
  id: battery

  readonly property int percentage: UPower.displayDevice.percentage * 100

  spacing: theme.padding * 0.5

  Text {
    color: theme.colors.green2
    font.pixelSize: theme.fontSizeSmall
    text: battery.percentage + "%"
  }
}

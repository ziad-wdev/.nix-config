import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower

RowLayout {
  id: battery

  readonly property int percentage: UPower.displayDevice.percentage * 100

  spacing: root.padding * 0.5

  Text {
    color: theme.colors.green2
    font.pixelSize: root.fontSize
    text: battery.percentage + "%"
  }
}

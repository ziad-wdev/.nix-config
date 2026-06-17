import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower

Rectangle {
  readonly property int percentage: UPowerDevice.percentage

  color: "transparent"
  implicitHeight: 16
  implicitWidth: 16

  IconImage {
    id: batteryIcon

    anchors.fill: parent
    source: Quickshell.iconPath("battery-level-" + 100 + "-symbolic")
  }
  MultiEffect {
    anchors.fill: batteryIcon
    colorization: 1.0
    colorizationColor: percentage < 20 ? "red" : "green"
    source: batteryIcon
  }
}

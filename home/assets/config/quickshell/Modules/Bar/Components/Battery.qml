import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

Rectangle {
  readonly property bool charging: UPower.displayDevice.charging
  readonly property int percentage: 100

  color: "transparent"
  implicitHeight: batteryItem.batterySize

  RowLayout {
    anchors.fill: parent
    spacing: 8

    Item {
      id: batteryItem

      readonly property int batterySize: 10

      implicitHeight: batterySize
      implicitWidth: batterySize * 2

      Rectangle {
        anchors.fill: parent
        anchors.rightMargin: batteryItem.batterySize / 12
        border.color: "white"
        border.width: batteryItem.batterySize / 6
        color: "transparent"
        radius: batteryItem.batterySize / 3
      }
      Rectangle {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        height: batteryItem.batterySize / 2
        radius: batteryItem.batterySize / 6
        width: batteryItem.batterySize / 12
      }
      Rectangle {
        color: percentage <= 20 ? "red" : "green"
        height: parent.height - 4
        radius: batteryItem.batterySize / 6
        width: (parent.width - batteryItem.batterySize / 2) * (percentage / 100)
        x: batteryItem.batterySize / 6
        y: batteryItem.batterySize / 6
      }
    }
    Text {
      text: 0 + "%"
    }
  }
}

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower

RowLayout {
  id: root

  readonly property var battery: UPower.displayDevice
  readonly property bool isCharging: battery.state === UPowerDeviceState.Charging
  readonly property bool isCritical: percentage <= 20
  readonly property bool isFull: percentage >= 100
  readonly property bool isEmpty: percentage <= 0
  readonly property int percentage: Math.round(battery.percentage * 100)
  readonly property string icon: {
    if (isCharging & isFull)
      return String.fromCodePoint(0xf0085);
    if (isCharging & isEmpty)
      return String.fromCodePoint(0xf089f);
    if (isCharging & (Math.floor(root.percentage / 10) === 0))
      return String.fromCodePoint(0xf089c);
    if (isCharging)
      return String.fromCodePoint(0xf0085 + Math.floor(root.percentage / 10));
    if (isFull)
      return String.fromCodePoint(0xf0079);
    if (isEmpty)
      return String.fromCodePoint(0xf008e);
    return String.fromCodePoint(0xf007a + Math.floor(root.percentage / 10));
  }

  spacing: 6

  Text {
    color: isCritical ? theme.colors.red2 : theme.colors.green2
    font.pixelSize: theme.fontSizeSmall
    text: icon
  }

  Text {
    color: isCritical ? theme.colors.red2 : theme.colors.green2
    font.pixelSize: theme.fontSizeSmall
    text: root.percentage + "%"
  }
}

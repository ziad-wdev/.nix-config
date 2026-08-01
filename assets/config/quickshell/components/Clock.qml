import QtQuick
import Quickshell

Text {
  id: clock

  color: theme.colors.primary2
  font.pixelSize: theme.fontSizeSmall
  text: "00:00 AM"

  Timer {
    interval: 1000
    repeat: true
    running: true
    triggeredOnStart: true

    onTriggered: parent.text = Qt.formatDateTime(new Date(), "d ddd hh:mm AP")
  }
}

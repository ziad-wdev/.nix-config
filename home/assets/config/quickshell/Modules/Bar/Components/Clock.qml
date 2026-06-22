import QtQuick
import Quickshell

Text {
  color: colors.primary2
  font.pixelSize: root.fontSize
  text: "00:00 AM"

  Timer {
    interval: 1000
    repeat: true
    running: true
    triggeredOnStart: true

    onTriggered: parent.text = Qt.formatDateTime(new Date(), "d ddd hh:mm AP")
  }
}

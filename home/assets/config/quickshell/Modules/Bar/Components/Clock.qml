import QtQuick
import Quickshell

Text {
  color: colors.primary2
  text: "00:00 AM"

  Timer {
    interval: 1000
    repeat: true
    running: true
    triggeredOnStart: true

    onTriggered: parent.text = new Date().toLocaleTimeString(Locale.Default, {
      hour: '2-digit',
      minute: '2-digit'
    })
  }
}

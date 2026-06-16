import QtQuick
import Quickshell

Text {
  text: "00:00 AM"
  color: colors.primary

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: parent.text = new Date().toLocaleTimeString(Locale.Default, {
      hour: '2-digit',
      minute: '2-digit'
    })
  }
}

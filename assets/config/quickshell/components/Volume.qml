import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

RowLayout {
  id: root

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool isReady: sink ? sink.ready : false
  readonly property bool isMuted: isReady ? sink.audio.muted : false
  readonly property int volume: isReady ? Math.round(sink.audio.volume * 100) : 0
  readonly property string icon: {
    if (!root.isReady)
      return String.fromCodePoint(0xf0581);
    if (root.isMuted)
      return String.fromCodePoint(0xf075f);
    if (root.volume === 0)
      return String.fromCodePoint(0xf057f);
    if (root.volume <= 66)
      return String.fromCodePoint(0xf0580);
    return String.fromCodePoint(0xf057e);
  }

  spacing: 6

  Text {
    color: theme.colors.orange2
    font.pixelSize: theme.fontSizeSmall
    text: root.icon
  }

  Text {
    color: theme.colors.orange2
    font.pixelSize: theme.fontSizeSmall
    text: root.volume + "%"
  }
}

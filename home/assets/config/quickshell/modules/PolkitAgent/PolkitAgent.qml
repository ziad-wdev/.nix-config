import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Polkit

PanelWindow {
  visible: polkitAgent.active
  color: "transparent"
  
  PolkitAgent {
    id: polkitAgent
  }
  Item {
    Column {
      anchors.horizontalCenter: parent.horizontalCenter

      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Authentication Required"
      }
      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: polkitAgent.flow ? polkitAgent.flow.message : ""
      }
    }
  }
}

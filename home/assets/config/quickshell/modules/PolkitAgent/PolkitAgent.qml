import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Polkit

PanelWindow {
  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.namespace: "quickshell:polkitagent"

  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  color: colors.alphaBackground
  visible: polkitAgent.isActive
  focusable: true

  PolkitAgent {
    id: polkitAgent
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      polkitAgent.flow?.cancelAuthenticationRequest();
    }
  }

  Shortcut {
    sequence: "Escape"
    onActivated: {
      polkitAgent.flow?.cancelAuthenticationRequest();
    }
  }

  onVisibleChanged: {
    if (visible)
      inputField.forceActiveFocus();
    inputField.text = null;
  }

  Rectangle {
    anchors.centerIn: parent

    implicitWidth: promptLayout.implicitWidth + root.padding * 4
    implicitHeight: promptLayout.implicitHeight + root.padding * 4
    color: colors.base00
    radius: root.radius * 2

    MouseArea {
      anchors.fill: parent
    }

    ColumnLayout {
      id: promptLayout

      anchors.centerIn: parent
      spacing: 32

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Authentication Required"
        font.pixelSize: 24
        color: colors.base07
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: polkitAgent.flow?.message || ""
        font.pixelSize: 16
        color: colors.base07
      }

      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: parent.width / 2
        implicitHeight: 2

        color: Qt.alpha(colors.primary, 0.1)
        radius: root.radius
      }

      TextField {
        id: inputField

        Layout.fillWidth: true
        implicitHeight: 48

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        cursorDelegate: Text {}

        background: Rectangle {
          radius: root.radius
          color: Qt.alpha(colors.primary, 0.1)
        }

        placeholderText: polkitAgent.flow?.isSuccessful ? polkitAgent.flow?.inputPrompt : "Authentication failed"
        placeholderTextColor: polkitAgent.flow?.isSuccessful ? colors.alphaForeground : Qt.alpha(colors.base08, 0.5)
        echoMode: TextInput.Password

        selectedTextColor: colors.base00
        selectionColor: colors.primary
        color: colors.base07
        font.pixelSize: 20

        onAccepted: {
          polkitAgent.flow?.submit(text);
          !polkitAgent.flow?.isSuccessful && (inputField.text = "");
        }
      }
    }
  }
}

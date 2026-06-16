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
      polkitAgent.flow.cancelAuthenticationRequest();
    }
  }

  Shortcut {
    sequence: "Escape"
    onActivated: {
      polkitAgent.flow.cancelAuthenticationRequest();
    }
  }

  onVisibleChanged: {
    if (visible)
      inputField.forceActiveFocus();
    inputField.text = "";
  }

  Rectangle {
    anchors.centerIn: parent

    implicitWidth: promptLayout.implicitWidth + root.padding * 4
    implicitHeight: promptLayout.implicitHeight + root.padding * 4
    color: colors.surface_container_lowest
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

        color: colors.alphaPrimary1
        radius: root.radius
      }

      TextField {
        id: inputField

        Layout.fillWidth: true
        implicitHeight: 48

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        placeholderText: polkitAgent.flow?.inputPrompt || "Password"
        placeholderTextColor: colors.alphaForeground
        echoMode: !text ? TextInput.Normal : TextInput.Password

        cursorDelegate: Text {}

        background: Rectangle {
          radius: root.radius
          color: colors.alphaPrimary1
        }

        selectedTextColor: colors.base00
        selectionColor: colors.primary
        color: colors.base07
        font.pixelSize: 24

        onAccepted: polkitAgent.flow.submit(text)
      }
    }
  }
}

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

        property int shakeOffset: 0

        Layout.fillWidth: true
        implicitHeight: 48

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        placeholderText: "Password"
        placeholderTextColor: colors.alphaForeground

        echoMode: TextInput.Password
        cursorDelegate: Text {}

        background: Rectangle {
          radius: root.radius
          color: Qt.alpha(colors.primary, 0.1)
          transform: Translate {
            x: -inputField.shakeOffset
          }
        }

        transform: Translate {
          x: inputField.shakeOffset
        }

        selectedTextColor: colors.base00
        selectionColor: colors.primary
        color: colors.base07
        font.pixelSize: 20

        onAccepted: {
          polkitAgent.flow.submit(text);
          errorAnimation.start();
        }

        ParallelAnimation {
          id: errorAnimation

          readonly property int delay: 50

          SequentialAnimation {
            PauseAnimation {
              duration: errorAnimation.delay
            }
            NumberAnimation {
              target: inputField
              property: "shakeOffset"
              to: -8
              duration: 50
            }
            NumberAnimation {
              target: inputField
              property: "shakeOffset"
              to: 8
              duration: 50
            }
            NumberAnimation {
              target: inputField
              property: "shakeOffset"
              to: -5
              duration: 50
            }
            NumberAnimation {
              target: inputField
              property: "shakeOffset"
              to: 5
              duration: 50
            }
            NumberAnimation {
              target: inputField
              property: "shakeOffset"
              to: 0
              duration: 50
            }
          }

          SequentialAnimation {
            PauseAnimation {
              duration: errorAnimation.delay
            }
            ColorAnimation {
              target: inputField
              property: "selectionColor"
              to: colors.base08
              duration: 50
            }
            ColorAnimation {
              target: inputField
              property: "selectionColor"
              to: colors.primary
              duration: 200
            }
          }

          SequentialAnimation {
            PauseAnimation {
              duration: errorAnimation.delay
            }
            ColorAnimation {
              target: inputField
              property: "color"
              to: colors.base08
              duration: 50
            }
            ColorAnimation {
              target: inputField
              property: "color"
              to: colors.base07
              duration: 200
            }
          }
        }
      }
    }
  }
}

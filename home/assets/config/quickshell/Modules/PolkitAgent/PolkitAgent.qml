import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Polkit

PanelWindow {
  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.namespace: "quickshell:polkitagent"
  anchors.bottom: true
  anchors.left: true
  anchors.right: true
  anchors.top: true
  color: Qt.alpha(colors.base00, 0.2)
  focusable: true
  visible: polkitAgent.isActive

  onVisibleChanged: {
    if (visible)
      inputField.forceActiveFocus();
    inputField.text = null;
  }

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
  Rectangle {
    anchors.centerIn: parent
    color: colors.base00
    implicitHeight: promptLayout.implicitHeight + root.padding * 4
    implicitWidth: promptLayout.implicitWidth + root.padding * 4
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
        color: colors.base07
        font.pixelSize: 24
        text: "Authentication Required"
      }
      Text {
        Layout.alignment: Qt.AlignHCenter
        color: colors.base07
        font.pixelSize: 16
        text: polkitAgent.flow?.message || ""
      }
      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: parent.width / 2
        color: Qt.alpha(colors.primary, 0.1)
        implicitHeight: 2
        radius: root.radius
      }
      TextField {
        id: inputField

        property int shakeOffset: 0

        Layout.fillWidth: true
        color: colors.base07
        echoMode: TextInput.Password
        font.pixelSize: 20
        horizontalAlignment: Qt.AlignHCenter
        implicitHeight: 48
        placeholderText: "Password"
        placeholderTextColor: Qt.alpha(colors.base07, 0.5)
        selectedTextColor: colors.base00
        selectionColor: colors.primary
        verticalAlignment: Qt.AlignVCenter

        background: Rectangle {
          color: Qt.alpha(colors.primary, 0.1)
          radius: root.radius

          transform: Translate {
            x: -inputField.shakeOffset
          }
        }
        cursorDelegate: Text {
        }
        transform: Translate {
          x: inputField.shakeOffset
        }

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
              duration: 50
              property: "shakeOffset"
              target: inputField
              to: -8
            }
            NumberAnimation {
              duration: 50
              property: "shakeOffset"
              target: inputField
              to: 8
            }
            NumberAnimation {
              duration: 50
              property: "shakeOffset"
              target: inputField
              to: -5
            }
            NumberAnimation {
              duration: 50
              property: "shakeOffset"
              target: inputField
              to: 5
            }
            NumberAnimation {
              duration: 50
              property: "shakeOffset"
              target: inputField
              to: 0
            }
          }
          SequentialAnimation {
            PauseAnimation {
              duration: errorAnimation.delay
            }
            ColorAnimation {
              duration: 50
              property: "selectionColor"
              target: inputField
              to: colors.base08
            }
            ColorAnimation {
              duration: 200
              property: "selectionColor"
              target: inputField
              to: colors.primary
            }
          }
          SequentialAnimation {
            PauseAnimation {
              duration: errorAnimation.delay
            }
            ColorAnimation {
              duration: 50
              property: "color"
              target: inputField
              to: colors.base08
            }
            ColorAnimation {
              duration: 200
              property: "color"
              target: inputField
              to: colors.base07
            }
          }
        }
      }
    }
  }
}

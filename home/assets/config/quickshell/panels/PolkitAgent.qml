import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Polkit

PanelWindow {
  id: root

  readonly property int padding: theme.padding * 4
  readonly property int radius: theme.radius * 2
  readonly property int inputPadding: theme.padding * 2
  readonly property int inputRadius: theme.radius
  readonly property int spacing: 20

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.namespace: "quickshell:polkitagent"
  anchors.bottom: true
  anchors.left: true
  anchors.right: true
  anchors.top: true
  focusable: true
  visible: polkitAgent.isActive
  color: theme.overlay

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
    implicitHeight: polkitPrompt.implicitHeight + root.padding
    implicitWidth: polkitPrompt.implicitWidth + root.padding
    anchors.centerIn: parent
    radius: root.radius
    color: theme.colors.bg0

    MouseArea {
      anchors.fill: parent
    }

    ColumnLayout {
      id: polkitPrompt

      anchors.centerIn: parent

      Text {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: root.spacing / 2
        color: theme.colors.fg0
        font.pixelSize: theme.fontSizeLarge
        text: "Authentication Required"
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: theme.fontSizeMedium
        color: theme.colors.fg2
        text: polkitAgent.flow?.message || ""
      }

      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: root.spacing
        Layout.topMargin: root.spacing
        Layout.preferredHeight: 2
        Layout.preferredWidth: parent.width * 0.5
        color: theme.colors.bg1
      }

      TextField {
        id: inputField

        property int shakeOffset: 0

        Layout.fillWidth: true
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        Layout.preferredHeight: font.pixelSize + root.inputPadding
        selectedTextColor: theme.colors.bg0
        selectionColor: theme.colors.primary2
        font.pixelSize: theme.fontSizeMedium
        echoMode: TextField.Password
        color: theme.colors.fg0

        background: Rectangle {
          radius: root.inputRadius
          color: theme.colors.bg1

          transform: Translate {
            x: -inputField.shakeOffset
          }
        }
        cursorDelegate: Text {}
        transform: Translate {
          x: inputField.shakeOffset
        }

        onAccepted: {
          polkitAgent.flow.submit(text);
          errorAnimation.start();
        }

        Text {
          anchors.fill: parent
          horizontalAlignment: Qt.AlignHCenter
          verticalAlignment: Qt.AlignVCenter
          visible: inputField.text.length === 0
          font.pixelSize: theme.fontSizeBase
          color: theme.colors.bg4
          text: "Password"
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
              to: theme.colors.red2
            }

            ColorAnimation {
              duration: 200
              property: "selectionColor"
              target: inputField
              to: theme.colors.primary2
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
              to: theme.colors.red2
            }

            ColorAnimation {
              duration: 200
              property: "color"
              target: inputField
              to: theme.colors.fg0
            }
          }
        }
      }
    }
  }
}

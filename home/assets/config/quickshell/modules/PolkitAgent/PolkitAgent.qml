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
  color: Qt.alpha(theme.colors.bg0, 0.2)
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
    color: theme.colors.bg0
    implicitHeight: promptLayout.implicitHeight + theme.padding * 4
    implicitWidth: promptLayout.implicitWidth + theme.padding * 4
    radius: theme.radius * 2

    MouseArea {
      anchors.fill: parent
    }
    ColumnLayout {
      id: promptLayout

      anchors.centerIn: parent

      Text {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: theme.padding
        color: theme.colors.fg0
        font.pixelSize: theme.fontSizeH3
        text: "Authentication Required"
      }
      Text {
        Layout.alignment: Qt.AlignHCenter
        color: theme.colors.fg4
        font.pixelSize: theme.fontSizeH4
        text: polkitAgent.flow?.message || ""
      }
      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: theme.padding * 1.5
        Layout.preferredHeight: 2
        Layout.preferredWidth: parent.width * 0.5
        Layout.topMargin: theme.padding * 1.5
        color: Qt.alpha(theme.colors.primary2, 0.1)
        radius: theme.radius
      }
      TextField {
        id: inputField

        property int shakeOffset: 0

        Layout.fillWidth: true
        Layout.preferredHeight: font.pixelSize + theme.padding * 2
        color: theme.colors.bg1
        echoMode: TextField.Password
        font.pixelSize: theme.fontSizeBase
        horizontalAlignment: Qt.AlignHCenter
        placeholderText: "Password"
        placeholderTextColor: theme.colors.bg2
        selectedTextColor: theme.colors.bg0
        selectionColor: theme.colors.primary2
        verticalAlignment: Qt.AlignVCenter

        background: Rectangle {
          color: theme.colors.bg1
          radius: theme.radius

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

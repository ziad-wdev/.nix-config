import QtQuick

QtObject {
  // Globals
  readonly property int padding: 16
  readonly property int radius: 12

  // Colors
  readonly property QtObject colors: Colors {}
  readonly property color overlay: Qt.alpha(colors.bg0, 0.2)

  // Animations
  readonly property int duration: 150
  readonly property var easingOut: Easing.OutQuad
  readonly property var easingIn: Easing.InQuad
  readonly property var easingInOut: Easing.InOutQuad
  readonly property var popIn: Easing.InBack
  readonly property var popOut: Easing.OutBack
  readonly property var popInOut: Easing.InOutBack

  // Typography
  readonly property int fontSizeHuge: Math.round(fontSizeBase * 2)
  readonly property int fontSizeLarge: Math.round(fontSizeBase * 1.5)
  readonly property int fontSizeMedium: Math.round(fontSizeBase * 1.25)
  readonly property int fontSizeBase: 16
  readonly property int fontSizeSmall: Math.round(fontSizeBase * 0.875)
}

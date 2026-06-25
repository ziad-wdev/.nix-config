import QtQuick

QtObject {
  readonly property int barInnerSpacing: 10
  readonly property int barOuterSpacing: 16
  property QtObject colors: Colors {
  }
  readonly property int fontSizeBase: 16
  readonly property int fontSizeH1: Math.round(fontSizeBase * 2.5)
  readonly property int fontSizeH2: Math.round(fontSizeBase * 2)
  readonly property int fontSizeH3: Math.round(fontSizeBase * 1.5)
  readonly property int fontSizeH4: Math.round(fontSizeBase * 1.25)
  readonly property int fontSizeSmall: Math.round(fontSizeBase * 0.875)
  readonly property int padding: 16
  readonly property int radius: 12
}

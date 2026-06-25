// @ pragma ShellId MyQuickshell
import QtQuick
import Quickshell

import "./panels" as Panels

ShellRoot {
  id: root

  Theme {
    id: theme
  }
  PolkitAgent {
  }
  Variants {
    model: Quickshell.screens

    delegate: Bar {
      property var modelData

      screen: modelData
    }
  }
}

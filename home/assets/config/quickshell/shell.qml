// @ pragma ShellId MyQuickshell
import QtQuick
import Quickshell

import "./modules/Theme"
import "./modules/Bar"
import "./modules/PolkitAgent"

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

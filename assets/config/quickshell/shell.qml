// @ pragma ShellId MyQuickshell
import QtQuick
import Quickshell

import "./shared"
import "./panels"

ShellRoot {
  id: rootShell

  Theme {
    id: theme
  }

  Variants {
    model: Quickshell.screens

    delegate: Bar {
      property var modelData

      screen: modelData
    }
  }

  PolkitAgent {}
}

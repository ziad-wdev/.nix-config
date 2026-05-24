{ config, ... }:

{
  programs.rofi.enable = true;

  xdg.configFile."rofi/scripts".source = ./rofi-scripts;

  xdg.configFile."rofi/colors.rasi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/matugen/output/rofi.rasi";

  # Grid theme
  xdg.configFile."rofi/grid-theme.rasi".text = ''
    /*****----- Configuration -----*****/
    configuration {
      font: "monospace 12";
      directories-first: true;
      show-icons: true;
      cycle: false;
      click-to-exit: true;
      hover-select: true;
      me-select-entry: "";
      me-accept-entry: "MousePrimary";
    }

    /*****----- Styles -----*****/
    @import "colors.rasi"

    * {
      background-color: inherit;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
      placeholder-color: #ffffff40;
      border-radius: 8px;
      padding: 4px;
    }
    window {
      width: 40%;
      background-color: @surface;
      text-color: @on-surface;
    }
    inputbar {
      background-color: @surface-container-lowest;
      spacing: 8px;
    }
    entry {
      cursor: text;
    }
    listview {
      fixed-columns: true;
      fixed-height: true;
      lines: 10;
      spacing: 6px;
      flow: horizontal;
      columns: 4;
      lines: 3;
    }
    element {
      cursor: pointer;
      orientation: vertical;
    }
    element selected {
      background-color: @primary;
    }
    element-icon {
      size: 4em;
    }
    element-icon selected {
      background-color: @on-primary;
    }
    element-text {
      horizontal-align: 0.5;
    }
    element-text selected {
      text-color: @on-primary;
    }
  '';

  # Main configuration
  xdg.configFile."rofi/config.rasi".text = ''
    /*****----- Theme -----*****/
    @theme "grid-theme.rasi"

    /*****----- Configuration -----*****/
    configuration {
      modi: "drun,window";
      display-drun: "  APPS";
      display-window: "󱂬  WINDOWS";
      drun-display-format: "{name}";
      window-format: "{w} · {c}";
    }
  '';
}

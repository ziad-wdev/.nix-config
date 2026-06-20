{
  config,
  pkgs,
  ...
}: {
  programs.rofi.enable = true;

  xdg.configFile."rofi/scripts/rofi-wallpapers.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      DIR="$HOME/Pictures/wallpapers"
      CACHE_DIR="$DIR/.cache"
      mkdir -p "$CACHE_DIR"

      set_wallpaper() {
        matugen image "$1" --source-color-index 0
      }

      mapfile -d ''' ALL_FILES < <(find "$DIR" -maxdepth 2 -name ".cache" -prune -o -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

      list_wallpapers() {
        for img in "''${ALL_FILES[@]}"; do
          filename="''${img##*/}"
          thumb="$CACHE_DIR/''${filename}.jpg"

          if [[ ! -f $thumb ]];
          then
            ${pkgs.imagemagick}/bin/magick -limit thread 1 -define jpeg:size=512x512 "$img" -filter Triangle -thumbnail 320x180^ -gravity center -extent 320x180 -quality 60 -strip "$thumb"
          fi

          name="''${filename%.*}"       # Remove extension
          name="''${name//[_-]/ }"      # Replace _ and - with space
          words=($name)                 # Split into array
          display_name="''${words[*]^}" # Capitalize first letter of each word

          printf '%s\0icon\x1f%s\x1finfo\x1f%s\n' "$display_name" "$thumb" "$img"
        done
      }

      selection_idx=$(list_wallpapers | rofi -dmenu -show-icons -format 'i' -theme-str 'element-icon { size: 150px; }' -p "󰸉  WALLPAPERS")

      if [[ -n $selection_idx && $selection_idx -ge 0 ]];
      then
        set_wallpaper "''${ALL_FILES[$selection_idx]}"
      fi
    '';
  };

  xdg.configFile."rofi/colors.rasi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/rofi.rasi";

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
      background-color: @bg0;
      text-color: @fg0;
    }
    inputbar {
      background-color: @bg1;
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
      background-color: @bg2;
    }
    element-icon {
      size: 4em;
    }
    element-icon selected {
      background-color: @bg1;
    }
    element-text {
      horizontal-align: 0.5;
    }
    element-text selected {
      text-color: @primary2;
    }
  '';

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

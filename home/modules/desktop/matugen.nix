{
  flakePath,
  config,
  pkgs,
  ...
}: let
  templatesPath = "${flakePath}/home/assets/templates";
  outputPath = "${config.xdg.dataHome}/themes";
in {
  home.packages = with pkgs; [
    matugen
  ];

  home.file."${outputPath}/.keep".text = "";

  xdg.configFile."matugen/config.toml".source = (pkgs.formats.toml {}).generate "config" {
    config = {
      wallpaper.command = "awww img --transition-type random --transition-fps 60 \"{{image}}\"";

      custom_colors = {
        red = {
          color = "#ff6048";
          blend = true;
        }; # base08
        orange = {
          color = "#ffa478";
          blend = true;
        }; # base09
        yellow = {
          color = "#f5cd5b";
          blend = true;
        }; # base0A
        green = {
          color = "#7ad9a8";
          blend = true;
        }; # base0B
        aqua = {
          color = "#3dd1b0";
          blend = true;
        }; # base0C
        blue = {
          color = "#5fc8d4";
          blend = true;
        }; # base0D
        purple = {
          color = "#e89aa8";
          blend = true;
        }; # base0E
      };
    };

    templates = {
      colors = {
        input_path = "${templatesPath}/colors.jsonc";
        output_path = "${outputPath}/colors.jsonc";
      };
    };
  };

  systemd.user.paths.templates-watcher = {
    Unit = {Description = "Watch for Matugen theme changes";};
    Path = {PathModified = "${outputPath}/colors.jsonc";};
    Install = {WantedBy = ["default.target"];};
  };

  systemd.user.services.templates-watcher = let
    templates-renderer = pkgs.writeShellScriptBin "render-templates" ''
      render() {
        local input="${templatesPath}/$1".mustache
        local output="${outputPath}/$2"
        local colors="${outputPath}/colors.jsonc"
        local clean_colors="${outputPath}/clean_colors.json"

        if [ -s "$colors" ]; then
          sed 's|//.*||g' "$colors" > "$clean_colors"
          ${pkgs.mustache-go}/bin/mustache "$clean_colors" "$input" > "$output"
        fi
      }

      #      input           output
      render colors.css      colors.css
      render gtk.css         gtk.css
      render gtk.css         wlogout.css
      render gtk.css         waybar.css
      render rofi.rasi       rofi.rasi
      render ghostty         ghostty
      render quickshell.qml  quickshell.qml
      render hyprland.lua    hyprland.lua
      render hyprlock.conf   hyprlock.conf
      render zed.json        zed.json
      render vesktop.css     vesktop.css

      # post hooks (run after template rendering)
      # gtk theme
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme none
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
      # waybar
      pkill -SIGUSR2 waybar || { pkill waybar; waybar & }
      # ghostty
      pkill -SIGUSR2 ghostty
      # hyprland
      hyprctl reload

      echo "Template updated successfully."
    '';
  in {
    Unit = {Description = "Render templates on theme change";};
    Service = {
      Type = "oneshot";
      ExecStart = "${templates-renderer}/bin/render-templates";
    };
  };
}

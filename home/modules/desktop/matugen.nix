{
  flakePath,
  config,
  pkgs,
  ...
}: let
  templatesPath = "${flakePath}/home/assets/templates";
  outputPath = "${config.xdg.dataHome}/themes";
in {
  home.packages = [pkgs.matugen];

  home.file."${outputPath}/.keep".text = "";

  xdg.configFile."matugen/config.toml".source = (pkgs.formats.toml {}).generate "config" {
    config = {
      wallpaper.command = "awww img --transition-type random --transition-fps 60 \"{{image}}\"";

      custom_colors = {
        base08 = {
          color = "#cc241d";
          blend = true;
        }; # red
        base09 = {
          color = "#d65d0e";
          blend = true;
        }; # orange
        base0A = {
          color = "#d79921";
          blend = true;
        }; # yellow
        base0B = {
          color = "#98971a";
          blend = true;
        }; # green
        base0C = {
          color = "#689d6a";
          blend = true;
        }; # aqua
        base0D = {
          color = "#458588";
          blend = true;
        }; # blue
        base0E = {
          color = "#b16286";
          blend = true;
        }; # purple
        base0F = {
          color = "#9d0006";
          blend = true;
        }; # pink
      };
    };

    templates = {
      gtk = {
        input_path = "${templatesPath}/gtk.css";
        output_path = "${outputPath}/gtk.css";
        post_hook = "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme none; sleep 0.05; ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'";
      };

      hyprland = {
        input_path = "${templatesPath}/hyprland.lua";
        output_path = "${outputPath}/hyprland.lua";
        post_hook = "hyprctl reload || true";
      };

      hyprlock = {
        input_path = "${templatesPath}/hyprlock.conf";
        output_path = "${outputPath}/hyprlock.conf";
      };

      quickshell = {
        input_path = "${templatesPath}/quickshell.qml";
        output_path = "${outputPath}/quickshell.qml";
      };

      wlogout = {
        input_path = "${templatesPath}/colors.css";
        output_path = "${outputPath}/wlogout.css";
      };

      waybar = {
        input_path = "${templatesPath}/colors.css";
        output_path = "${outputPath}/waybar.css";
        post_hook = "command -v waybar &>/dev/null && (pkill -SIGUSR2 waybar || waybar &) || true";
      };

      rofi = {
        input_path = "${templatesPath}/rofi.rasi";
        output_path = "${outputPath}/rofi.rasi";
      };

      ghostty = {
        input_path = "${templatesPath}/ghostty";
        output_path = "${outputPath}/ghostty";
        post_hook = "pkill -SIGUSR2 ghostty || true";
      };

      zed = {
        input_path = "${templatesPath}/zed.json";
        output_path = "${outputPath}/zed.json";
      };

      vesktop = {
        input_path = "${templatesPath}/vesktop.css";
        output_path = "${outputPath}/vesktop.css";
      };

      obs = {
        input_path = "${templatesPath}/obs.obt";
        output_path = "${outputPath}/obs.obt";
      };
    };
  };
}

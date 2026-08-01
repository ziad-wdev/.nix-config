{
  flakePath,
  config,
  pkgs,
  ...
}: let
  # Use config.hm to access Home Manager's XDG paths
  templatesPath = "${flakePath}/assets/templates";
  outputPath = "${config.hm.xdg.dataHome}/themes";
  colorsTemplate = "colors.yaml";
in {
  hm = {
    home.packages = with pkgs; [matugen];

    xdg.configFile."matugen/config.toml".source = (pkgs.formats.toml {}).generate "config" {
      config = {
        wallpaper.command = "awww img --transition-type random --transition-fps 60 \"{{ image }}\"";

        custom_colors = {
          red = {
            color = "#ff6048";
            blend = true;
          };
          orange = {
            color = "#ffa478";
            blend = true;
          };
          yellow = {
            color = "#f5cd5b";
            blend = true;
          };
          green = {
            color = "#7ad9a8";
            blend = true;
          };
          aqua = {
            color = "#3dd1b0";
            blend = true;
          };
          blue = {
            color = "#5fc8d4";
            blend = true;
          };
          purple = {
            color = "#e89aa8";
            blend = true;
          };
        };
      };

      templates = {
        colors = {
          input_path = "${templatesPath}/${colorsTemplate}";
          output_path = "${outputPath}/${colorsTemplate}";
        };
      };
    };

    # Moved systemd user services inside Home Manager
    systemd.user.paths.templates-watcher = {
      Unit.Description = "Watch for Matugen theme changes";
      Path.PathModified = "${outputPath}/${colorsTemplate}";
      Install.WantedBy = ["default.target"];
    };

    systemd.user.services.templates-watcher = let
      templates-renderer = pkgs.writeShellScriptBin "render-templates" ''
        colors="${outputPath}/${colorsTemplate}"
        colorsJSON="${outputPath}/colors.json"

        if [ -s "$colors" ]; then
          ${pkgs.yq-go}/bin/yq -o=json "$colors" > "$colorsJSON"
        else
          echo "Error: $colors is empty or missing."
          exit 1
        fi

        render() {
          local input="${templatesPath}/$1".mustache
          local output="${outputPath}/$2"
          ${pkgs.mustache-go}/bin/mustache "$colorsJSON" "$input" > "$output"
        }

        render colors.qml      colors.qml
        render colors.css      colors.css
        render gtk.css         gtk.css

        render hyprland.lua    hyprland.lua
        render ghostty         ghostty
        render zed.json        zed.json
        render vesktop.css     vesktop.css

        render gtk.css         wlogout.css
        render gtk.css         waybar.css
        render rofi.rasi       rofi.rasi

        # post hooks
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme none
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
        pkill -SIGUSR2 waybar || { pkill waybar; waybar & }
        pkill -SIGUSR2 ghostty
        ${pkgs.hyprland}/bin/hyprctl reload
      '';
    in {
      Unit.Description = "Render templates on theme change";
      Service = {
        Type = "oneshot";
        ExecStart = "${templates-renderer}/bin/render-templates";
      };
    };
  };
}

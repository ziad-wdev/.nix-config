{ flakePath, config, pkgs, ... }:

let
  templatesPath = "${flakePath}/home/assets/templates";
  outputPath = "${config.xdg.dataHome}/themes";
in
{
  home.packages = [ pkgs.matugen ];

  home.file."${outputPath}/.keep".text = "";

  xdg.configFile."matugen/config.toml".source = (pkgs.formats.toml {}).generate "config" {
    config = {
      wallpaper.command = "awww img --transition-type random --transition-fps 60 \"{{image}}\"";

      custom_colors = {
        red     = { color = "#ff6467"; blend = true; };
        orange  = { color = "#ff8904"; blend = true; };
        amber   = { color = "#ffba00"; blend = true; };
        yellow  = { color = "#fcc800"; blend = true; };
        lime    = { color = "#9ae600"; blend = true; };
        green   = { color = "#05df72"; blend = true; };
        emerald = { color = "#00d492"; blend = true; };
        teal    = { color = "#00d5be"; blend = true; };
        cyan    = { color = "#00d3f2"; blend = true; };
        sky     = { color = "#00bcff"; blend = true; };
        blue    = { color = "#51a2ff"; blend = true; };
        indigo  = { color = "#7c86ff"; blend = true; };
        violet  = { color = "#a684ff"; blend = true; };
        purple  = { color = "#c27aff"; blend = true; };
        fuchsia = { color = "#ed6aff"; blend = true; };
        pink    = { color = "#fb64b6"; blend = true; };
        rose    = { color = "#ff637e"; blend = true; };
        navy    = { color = "#193cb8"; blend = true; };
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

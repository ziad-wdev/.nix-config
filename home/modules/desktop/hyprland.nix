{
  flakePath,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    awww
    hyprshot
    hyprpicker
    wl-clipboard
    brightnessctl
  ];

  xdg.configFile = {
    "hypr/hyprland.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/hypr/hyprland.lua";

    "hypr/modules".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/hypr/modules";

    "hypr/colors.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/hyprland.lua";
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "lockscreen";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -e4 -s set 25%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 1200;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1350;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      source = ["${config.xdg.dataHome}/themes/hyprlock.conf"];
      background = [
        {
          monitor = "";
          path = "$image";
          blur_size = 10;
          blur_passes = 3;
          contrast = 0.9;
          noise = 0.025;
          brightness = 0.5;
          vibrancy = 0.2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "$primary2";
          font_size = 256;
          font_family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "$primary2";
          outer_color = "$primary2";
          check_color = "$primary2";
          fail_color = "$red2";
          size = "200, 50";
          outline_thickness = 0;
          dots_size = 0.32;
          dots_spacing = 0.16;
          dots_center = true;
          fade_on_empty = true;
          placeholder_text = "<i>Password</i>";
          hide_input = false;
          position = "0, -300";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

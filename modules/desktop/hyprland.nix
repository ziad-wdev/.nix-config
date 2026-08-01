{
  flakePath,
  config,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  hm = {
    services.hypridle.enable = true;
    programs.hyprlock.enable = true;
    home.packages = with pkgs; [
      awww
      hyprshot
      hyprpicker
      wl-clipboard
      brightnessctl
    ];

    xdg.configFile = {
      "hypr".source =
        config.hm.lib.file.mkOutOfStoreSymlink "${flakePath}/assets/config/hypr";

      "${flakePath}/assets/config/hypr/modules/colors.lua".source =
        config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.xdg.dataHome}/themes/hyprland.lua";
    };
  };
}

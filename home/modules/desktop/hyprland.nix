{
  flakePath,
  config,
  pkgs,
  ...
}: {
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
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/hypr";

    "${flakePath}/home/assets/config/hypr/modules/colors.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/hyprland.lua";
  };
}

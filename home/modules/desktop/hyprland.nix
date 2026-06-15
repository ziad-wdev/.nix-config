{ flakePath, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprshot
    hyprpicker
  ];

  xdg.configFile.

  xdg.configFile = {
    "hypr/hyprland.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/hypr/hyprland.lua";

    "hypr/modules".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/hypr/modules";

    "hypr/colors.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/hyprland.lua";
  };
}

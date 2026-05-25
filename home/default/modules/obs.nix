{ config, pkgs, ... }:

{
  xdg.configFile."obs-studio/themes/custom.obt".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/matugen/output/obs.obt";

  xdg.configFile."obs-studio/global.ini".text = ''
    [General]
    Theme=custom
  '';

  programs.obs-studio = {
    enable = true;
  };
}

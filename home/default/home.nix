{ username, pkgs, ... }:

let
  dotFiles = ./modules;
in
{
  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/fastfetch.nix

    ./modules/hyprland.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix

    ./modules/theme.nix
    ./modules/waybar.nix
    ./modules/rofi.nix
    ./modules/wlogout.nix
    ./modules/ghostty.nix
    ./modules/nautilus.nix
    ./modules/matugen.nix

    ./modules/zed.nix
    ./modules/firefox.nix
  ];

  home = {
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
    username = "${username}";
  };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile = {
    "rofi" = {
      source = "${dotFiles}/rofi";
      recursive = true;
    };
  };
}

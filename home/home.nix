{
  stateVersion,
  username,
  ...
}: let
  loadModules = attrs:
    builtins.concatMap (key: map (val: ./. + "/${key}/${val}.nix") attrs.${key}) (
      builtins.attrNames attrs
    );

  modulePaths = loadModules {
    "modules/apps" = [
      "vesktop"
      "zed"
      "zen"
    ];
    "modules/desktop" = [
      "ghostty"
      "hypridle"
      "hyprland"
      "hyprlock"
      "matugen"
      "nautilus"
      "quickshell"
      "rofi"
      "theme"
      "waybar"
      "wlogout"
    ];
    "modules/shell" = [
      "fastfetch"
      "git"
      "pnpm"
      "treefmt"
      "zsh"
    ];
  };
in {
  imports = modulePaths;

  home = {
    homeDirectory = "/home/${username}";
    inherit stateVersion;
    username = "${username}";
  };

  programs.home-manager.enable = true;
}

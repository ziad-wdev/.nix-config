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
      "ghostty"
      "nautilus"
      "vesktop"
      "zed"
      "zen"
    ];
    "modules/desktop" = [
      "hyprland"
      "matugen"
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
    username = "${username}";
    inherit stateVersion;
  };

  programs.home-manager.enable = true;
}

{inputs, ...}: let
  theme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
in {
  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = false;
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      maxGenerations = 10;
      enableEditor = true;
      efiInstallAsRemovable = true;
      style.wallpapers = [];
      extraConfig = with theme.palette; ''
        background_style: color
        backdrop: ${base00}
        term_background: ${base00}
        term_foreground: ${base05}
        term_palette: ${base00};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base05}
        term_palette: ${base03};${base09};${base01};${base02};${base04};${base06};${base0F};${base07}
      '';
    };
  };

  console.colors = with theme.palette; [
    base00 # 0:  Black
    base08 # 1:  Red
    base0B # 2:  Green
    base0A # 3:  Yellow
    base0D # 4:  Blue
    base0E # 5:  Magenta
    base0C # 6:  Cyan
    base05 # 7:  White
    base03 # 8:  Bright Black
    base09 # 9:  Bright Red / Orange
    base01 # 10: Bright Green
    base02 # 11: Bright Yellow
    base04 # 12: Bright Blue
    base06 # 13: Bright Magenta
    base0F # 14: Bright Cyan
    base07 # 15: Bright White
  ];
}

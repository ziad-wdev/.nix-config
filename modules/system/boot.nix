_: let
  mocha = {
    base00 = "1e1e2e";
    base01 = "181825";
    base02 = "313244";
    base03 = "45475a";
    base04 = "585b70";
    base05 = "cdd6f4";
    base06 = "f5e0dc";
    base07 = "b4befe";
    base08 = "f38ba8";
    base09 = "fab387";
    base0A = "f9e2af";
    base0B = "a6e3a1";
    base0C = "94e2d5";
    base0D = "89b4fa";
    base0E = "cba6f7";
    base0F = "f2cdcd";
  };
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
      extraConfig = ''
        term_background=#${mocha.base00}
        term_foreground=#${mocha.base05}
        term_palette=#${mocha.base00};#${mocha.base08};#${mocha.base0B};#${mocha.base0A};#${mocha.base0D};#${mocha.base0E};#${mocha.base0C};#${mocha.base05}
      '';
    };
  };

  console.colors = [
    mocha.base00 # 0:  Black
    mocha.base08 # 1:  Red
    mocha.base0B # 2:  Green
    mocha.base0A # 3:  Yellow
    mocha.base0D # 4:  Blue
    mocha.base0E # 5:  Magenta
    mocha.base0C # 6:  Cyan
    mocha.base05 # 7:  White
    mocha.base03 # 8:  Bright Black
    mocha.base09 # 9:  Bright Red / Orange
    mocha.base01 # 10: Bright Green
    mocha.base02 # 11: Bright Yellow
    mocha.base04 # 12: Bright Blue
    mocha.base06 # 13: Bright Magenta
    mocha.base0F # 14: Bright Cyan
    mocha.base07 # 15: Bright White
  ];
}

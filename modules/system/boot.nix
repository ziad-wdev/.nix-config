{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = false;
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      maxGenerations = 10;
      enableEditor = true;
      efiInstallAsRemovable = true;
      style = {
        wallpapers = [
          (pkgs.fetchurl {
            url = "https://port8080.sh/images/limine-splash.png";
            sha256 = "sha256-+S8J+XKbIpfNKbN76/yBEpbYx3FUiXQ5Ut5LmBeFAt8=";
          })
        ];
        wallpaperStyle = "stretched";
      };
    };
  };
}

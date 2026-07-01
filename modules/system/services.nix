{pkgs, ...}: {
  # network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # essential services
  services.gvfs.enable = true;
  services.tlp.enable = true;
  services.upower.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # ram optimization services
  services.earlyoom = {
    enable = true;
    extraArgs = [
      "-g"
      "--prefer '^(electron|chrome|firefox|zen-browser)$'"
      "--avoid '^(Xorg|wayland|nix-daemon|hyprland|waybar|gnome-keyring-daemon|pipewire|wireplumber)$'"
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.vfs_cache_pressure" = 50;
    "vm.page-cluster" = 0;
  };

  # compatibility services
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      libsecret
      glib
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

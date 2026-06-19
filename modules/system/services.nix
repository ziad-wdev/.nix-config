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
  services.tlp.enable = true;
  services.upower.enable = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # compatibility services
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libsecrets
      glib
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

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

  # compatibility services
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libsecret
      glib
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

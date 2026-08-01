{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # System utilities
    _7zz-rar
    ouch

    # UI applications
    resources # Resource manger
    showtime # video player
    papers # doc viewer
    loupe # Image viewer
  ];

  # Enable Docker for containerization and NVIDIA container toolkit.
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}

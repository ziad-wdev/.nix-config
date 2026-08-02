{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # UI applications
    resources # Resource manger
    showtime # video player
    papers # doc viewer
    loupe # Image viewer
  ];

  # Enable Docker for containerization and NVIDIA container toolkit.
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;
}

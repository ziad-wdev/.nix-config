{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    ouch
    _7zz-rar

    # UI applications
    resources # Resource management
    showtime # video player
    loupe # Image viewer
    icon-library # GNOME Icon Library

    # Gaming applications
    lutris
    wineWow64Packages.stable
  ];

  # Enable Zsh as the default shell for users.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable Docker for containerization and NVIDIA container toolkit.
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;

  # Enable Steam
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
}

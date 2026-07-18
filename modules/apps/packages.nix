{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # System utilities
    nodejs-slim
    _7zz-rar
    ouch

    rendercv

    # UI applications
    resources # Resource manger
    showtime # video player
    papers # doc viewer
    loupe # Image viewer

    # Gaming applications
    wineWow64Packages.stable
    protonup-ng
    lutris
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}

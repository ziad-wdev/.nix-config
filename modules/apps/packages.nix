{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    lutris # Game launcher

    gnome-disk-utility # Disk utility
    resources # Resource management
    baobab # Disk usage analyzer
    showtime # video player
    loupe # Image viewer
    icon-library # GNOME Icon Library

    # System utilities
    curl
    ouch
    _7zz-rar
  ];

  # Disable tests for openldap to avoid build failures for lutris
  nixpkgs.overlays = [
    (_final: prev: {
      openldap = prev.openldap.overrideAttrs (_old: {
        doCheck = false;
      });
    })
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

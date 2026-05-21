{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Image utilities
    loupe # Image viewer

    # System utilities
    gh
    git
    curl
    unzip
    perl
    imagemagick

    # Wayland clipboard utilities
    wl-clipboard
    # Brightness control
    brightnessctl
  ];

  # Enable GVFS for file system access. (for nautilus)
  services.gvfs.enable = true;

  # Configure zsh shell.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Library for rendering SVG icons
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}

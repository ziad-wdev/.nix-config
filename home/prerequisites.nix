{ pkgs, ... }:

{
  # Required by hyprland.nix -> for Hyprland window manager
  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  # Required by zsh.nix -> for Zsh shell privileges
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Required by nautilus.nix -> for file system access
  services.gvfs.enable = true;

  # Required by wlogout.nix -> for svg icon rendering
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}

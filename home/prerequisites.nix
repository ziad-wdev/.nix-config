{pkgs, ...}: {
  # Required by hyprland.nix -> for Hyprland window manager
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config = {
      common = {
        default = ["gtk"];
      };
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.Settings" = ["gtk"];
      };
    };
  };

  # Required by quickshell.nix -> for Qucikshell services
  services.upower.enable = true;
  security.polkit.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Required by zsh.nix -> for Zsh shell privileges
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Required by nautilus.nix -> for file system access
  services.gvfs.enable = true;

  # Required by wlogout.nix -> for svg icon rendering
  programs.gdk-pixbuf.modulePackages = with pkgs; [librsvg];
}

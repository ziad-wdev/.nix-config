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

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Required by zsh.nix -> for Zsh shell privileges
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Required by nautilus.nix -> for file system access
  services.gvfs.enable = true;

  # Required by wlogout.nix -> for svg icon rendering
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}

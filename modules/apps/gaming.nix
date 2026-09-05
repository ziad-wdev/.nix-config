{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    protonup-ng
    lutris
  ];

  # Enable Steam
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
}

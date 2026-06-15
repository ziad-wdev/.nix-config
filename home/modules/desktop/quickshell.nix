{ flakePath, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
    qt6.qt5compat
    qt6.qtwayland
  ];

  xdg.configFile = {
    "quickshell/shell.qml".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell/shell.qml";

    "quickshell/modules".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell/modules";

    "quickshell/Colors.qml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/quickshell.qml";
  };

  # systemd.user.services.quickshell = {
  #   Unit = {
  #     Description = "Quickshell Desktop Components";
  #     After = [ "graphical-session.target" ];
  #     PartOf = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.quickshell}/bin/quickshell";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };
}

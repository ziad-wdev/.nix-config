{
  flakePath,
  config,
  pkgs,
  ...
}: {
  programs.quickshell.enable = true;
  home.sessionVariables = {
    QML2_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
  };

  xdg.configFile = {
    "quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell";

    "${flakePath}/home/assets/config/quickshell/shared/Colors.qml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/colors.qml";
  };
}

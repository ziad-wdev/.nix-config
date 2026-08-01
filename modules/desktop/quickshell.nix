{
  flakePath,
  config,
  pkgs,
  ...
}: {
  hm = {
    programs.quickshell.enable = true;
    home.sessionVariables = {
      QML2_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
    };

    xdg.configFile = {
      "quickshell".source =
        config.hm.lib.file.mkOutOfStoreSymlink "${flakePath}/assets/config/quickshell";

      "${flakePath}/assets/config/quickshell/shared/Colors.qml".source =
        config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.xdg.dataHome}/themes/colors.qml";
    };
  };
}

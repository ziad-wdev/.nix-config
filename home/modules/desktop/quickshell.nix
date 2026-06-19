{
  flakePath,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    quickshell
    qt6.qtsvg
    qt6.qtwayland
    qt6.qt5compat
    qt6.qtmultimedia
    qt6.qtimageformats
  ];

  home.sessionVariables = {
    QML_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
    QML2_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
  };

  xdg.configFile = {
    "quickshell/shell.qml".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell/shell.qml";

    "quickshell/Modules".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell/Modules";

    "quickshell/Icons".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/assets/config/quickshell/Icons";

    "quickshell/Colors.qml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/quickshell.qml";
  };
}

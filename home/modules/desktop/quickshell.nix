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
}

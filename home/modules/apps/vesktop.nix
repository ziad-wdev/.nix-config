{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
  ];

  xdg.configFile."vesktop/themes/custom.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/vesktop.css";

  xdg.configFile."vesktop/settings.json".text = builtins.toJSON {
    discordBranch = "stable";
    minimizeToTray = true;
    startMinimized = false;
    openDevTools = false;
    hardwareAcceleration = true;
    flavour = "vanilla";

    electronFlags = "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
  };

  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    notifyAboutUpdates = false;
    autoUpdate = false;
    autoUpdateNotification = false;
    useQuickCss = true;

    enabledThemes = [
      "custom.css"
    ];

    plugins = {
      FakeNitro = {
        enabled = true;
      };
      ClearURLs = {
        enabled = true;
      };
      VolumeBooster = {
        enabled = true;
      };
      PlatformIndicators = {
        enabled = true;
      };
      MessageLogger = {
        enabled = true;
        ignoreSelf = true;
      };
    };
  };
}

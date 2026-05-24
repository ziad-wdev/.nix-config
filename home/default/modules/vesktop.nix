{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
  ];

  xdg.configFile."vesktop/themes/custom.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/matugen/output/vesktop.css";

  # Directly manage the Vesktop config file in the XDG config directory
  xdg.configFile."vesktop/settings.json".text = builtins.toJSON {
    # Visual Tweaks
    discordBranch = "stable";
    minimizeToTray = true;
    startMinimized = false;
    openDevTools = false;

    # Performance & Wayland support
    hardwareAcceleration = true;
    flavour = "vanilla"; # Uses stock Vencord

    # Enables smooth window dragging and window decorations on Wayland
    electronFlags = "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
  };

  # 2. Vencord Settings (Plugins & Themes)
  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    notifyAboutUpdates = false;
    autoUpdate = false;
    autoUpdateNotification = false;
    useQuickCss = true;

    # Enable your local custom theme file
    enabledThemes = [
      "custom.css"
    ];

    # Toggle Vencord plugins on (true) or off (false)
    plugins = {
      FakeNitro = { enabled = true; };
      ClearURLs = { enabled = true; };
      VolumeBooster = { enabled = true; };
      PlatformIndicators = { enabled = true; };
      MessageLogger = {
        enabled = true;
        ignoreSelf = true;
      };
    };
  };
}

{config, ...}: {
  xdg.configFile."ghostty/themes/custom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/ghostty";

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "custom";
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      cursor-style = "block";
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
      confirm-close-surface = false;
      copy-on-select = false;
      gtk-titlebar = false;
      config-errors = "ignore";
      gtk-single-instance = true;
      scrollback-limit = 4096;
      app-notifications = "no-clipboard-copy,no-config-reload";
      shell-integration-features = "cursor,sudo,title,no-cursor";
      shell-integration = "detect";
      keybind = [
        "ctrl+c=copy_to_clipboard"
        "ctrl+v=paste_from_clipboard"
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
        "shift+enter=text:\\n"
        "ctrl+z=text:\\x03"
      ];
    };
  };
}

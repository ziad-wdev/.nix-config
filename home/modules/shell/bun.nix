{config, ...}: {
  programs.bun = {
    enable = true;
    settings = {
      telemetry = false;
      install = {
        globalDir = "${config.xdg.dataHome}/bun/install/global";
        globalBinDir = "${config.xdg.dataHome}/bun/bin";
        linker = "isolated";
        optional = true;
        exact = true;
      };

      run = {
        bun = true;
      };
    };
  };

  home.sessionVariables = {
    BUN_INSTALL_CACHE_DIR = "${config.xdg.cacheHome}/bun/install/cache";
  };
}

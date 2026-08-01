{config, ...}: {
  hm = {
    programs.bun = {
      enable = true;
      settings = {
        telemetry = false;
        install = {
          globalDir = "${config.hm.xdg.dataHome}/bun/install/global";
          globalBinDir = "${config.hm.xdg.dataHome}/bun/bin";
          linker = "isolated";
          optional = true;
          exact = true;
        };

        run = {
          bun = true;
        };
      };
    };

    home.sessionPath = [
      "${config.hm.xdg.dataHome}/bun/bin"
    ];

    home.sessionVariables = {
      BUN_INSTALL = "${config.hm.xdg.dataHome}/bun";
      BUN_INSTALL_CACHE_DIR = "${config.hm.xdg.cacheHome}/bun";
      NPM_CONFIG_CACHE = "${config.hm.xdg.cacheHome}/npm";
    };
  };
}

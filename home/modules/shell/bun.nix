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
}

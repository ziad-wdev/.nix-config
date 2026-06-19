{config, ...}: {
  programs.bun = {
    enable = true;

    settings = {
      telemetry = false;

      install = {
        globalDir = "${config.xdg.dataHome}/bun/install/global";
        globalBinDir = "${config.xdg.dataHome}/bun/bin";

        exact = true;
        optional = true;
        linker = "isolated";
      };

      run = {
        bun = true;
      };
    };
  };
}

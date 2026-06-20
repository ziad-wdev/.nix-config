{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.finegrained = true;
      powerManagement.enable = true;
      modesetting.enable = true;
      open = false;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}

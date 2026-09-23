{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # UI applications
    gnome-disk-utility # Disk manger
    pavucontrol # Audio manager
    resources # Resource manger
    showtime # video player
    papers # doc viewer
    loupe # Image viewer

    # Development tools
    postman
    rendercv
    ffmpeg

    davinci-resolve
    (lib.hiPrio (writeShellScriptBin "davinci-resolve" ''
      export OCL_ICD_VENDORS=nvidia.icd
      exec nvidia-offload ${davinci-resolve}/bin/davinci-resolve "$@"
    ''))
  ];

  # Enable Docker for containerization and NVIDIA container toolkit.
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;
}

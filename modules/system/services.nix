{pkgs, ...}: {
  # network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # power management
  services.upower.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # AC: Responsive performance
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_BOOST_ON_AC = 1;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      RUNTIME_PM_ON_AC = "on";

      # Battery: Max efficiency
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_BAT = 0;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_DENYLIST = "00:14.3";

      # Battery Charge Thresholds
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Devices to disable on startup
      DEVICES_TO_DISABLE_ON_STARTUP = "";
    };
  };

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
  '';

  # essential services
  services.gvfs.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # ram optimization services
  services.earlyoom = {
    enable = true;
    extraArgs = [
      "-g"
      "--prefer '^(electron|chrome|firefox|zen-browser)$'"
      "--avoid '^(Xorg|wayland|nix-daemon|hyprland|waybar|gnome-keyring-daemon|pipewire|wireplumber)$'"
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 60;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.vfs_cache_pressure" = 100;
    "vm.page-cluster" = 0;
  };

  # compatibility services
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      libsecret
      glib
      nss

      stdenv.cc.cc.lib
      libxkbcommon
      gdk-pixbuf
      fontconfig
      freetype
      alsa-lib
      libdrm
      libgbm
      cairo
      pango
      expat
      nspr
      cups
      mesa
      dbus
      gtk3
      atk
      libxcomposite
      libxcursor
      libxdamage
      libxrender
      libxrandr
      libxfixes
      libxext
      libx11
      libxcb
      libxi
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

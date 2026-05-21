{ config, pkgs, username, ... }:

{
  # Configure the system state version.
  system.stateVersion = "26.05";

  # Configure Nix settings.
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    use-xdg-base-directories = true;
    auto-optimise-store = true;
    keep-derivations = true;
    keep-outputs = true;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    allowReboot = false;
    runGarbageCollection = true;
    flake = "/etc/nixos#default";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
  };

  # Configure the network.
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Configure bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Set the time zone to Cairo.
  time.timeZone = "Africa/Cairo";

  # Create the user.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Configure the boot loader.
  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = false;
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      efiInstallAsRemovable = true;
      maxGenerations = 5;
      enableEditor = true;
      style = {
        wallpapers = [
          (pkgs.fetchurl {
            url = "https://port8080.sh/images/limine-splash.png";
            sha256 = "sha256-+S8J+XKbIpfNKbN76/yBEpbYx3FUiXQ5Ut5LmBeFAt8=";
          })
        ];
        wallpaperStyle = "stretched";
      };
    };
  };

  # Enable sddm.
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    extraPackages = [ pkgs.bibata-cursors ];
  };
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # Enable hyprland and setup the environment.
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Enable gnome-keyring for password management.
  services.gnome.gnome-keyring.enable = true;

  # Enable polkit for system-wide policy management.
  security.polkit.enable = true;
}

{
  flakePath,
  stateVersion,
  username,
  ...
}: let
  loadModules = attrs:
    builtins.concatMap (key: map (val: ./. + "/${key}/${val}.nix") attrs.${key}) (
      builtins.attrNames attrs
    );

  modulePaths = loadModules {
    "modules/apps" = [
      "flatpaks"
      "hyprland"
      "packages"
      "sddm"
    ];

    "modules/system" = [
      "boot"
      "disko"
      "hardware"
      "netlimit"
      "nvidia"
      "services"
    ];
  };
in {
  imports = modulePaths;
  system.stateVersion = stateVersion;
  time.timeZone = "Africa/Cairo";
  nix.settings = {
    use-xdg-base-directories = true;
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    allowReboot = false;
    flake = flakePath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "docker"
    ];
  };
}

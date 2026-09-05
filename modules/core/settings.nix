{flakePath, ...}: {
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
}

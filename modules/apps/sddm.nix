{
  inputs,
  username,
  pkgs,
  ...
}:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-mocha";
  };

  systemd.tmpfiles.rules =
    let
      avatar = pkgs.fetchurl {
        url = "https://i.pinimg.com/736x/5e/58/41/5e5841627401c23e62b2ce6a4f2d4f04.jpg";
        sha256 = "sha256-ji3HmHcPUvPZeLboONdhN91vWKW4qkx7TW53P2RUiwM=";
      };
    in
    [
      "f+ /var/lib/AccountsService/users/${username} 0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n"
      "L+ /var/lib/AccountsService/icons/${username} - - - - ${avatar}"
    ];

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };

    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];

  systemd.services.sddm.environment = {
    KWIN_FORCE_SW_CURSOR = "1";
  };
}

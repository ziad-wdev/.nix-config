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
        sha256 = "";
      };
    in
    [
      "f+ /var/lib/AccountsService/users/${username} 0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n"
      "L+ /var/lib/AccountsService/icons/${username} - - - - ${avatar}"
    ];

  environment.systemPackages = with pkgs; [ bibata-cursors ];

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
}

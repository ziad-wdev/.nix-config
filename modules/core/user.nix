{
  stateVersion,
  username,
  ...
}: {
  system.stateVersion = stateVersion;
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

  hm = {
    programs.home-manager.enable = true;
    home = {
      homeDirectory = "/home/${username}";
      inherit username;
      inherit stateVersion;
    };
  };
}

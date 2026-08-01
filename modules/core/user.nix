{username, ...}: {
  system.stateVersion = "26.05";
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
      stateVersion = "26.05";
      inherit username;
    };
  };
}

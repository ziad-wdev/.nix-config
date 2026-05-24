{ username, lib, ... }:

let
  # Get all files in ./modules
  dir = ./modules;
  files = builtins.readDir dir;

  # Filter for .nix files and exclude this current file if necessary
  nixFiles = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name
  ) files;

  # Create a list of full paths
  importList = lib.mapAttrsToList (name: _: dir + "/${name}") nixFiles;
in
{
  imports = importList;

  home = {
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
    username = "${username}";
  };

  programs.home-manager.enable = true;
}

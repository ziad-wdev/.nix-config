{ inputs, username, stateVersion, ... }:

let
  modulePaths = builtins.concatMap
    (category:
      let
        categoryPath = ./modules + "/${category}";
      in
      if builtins.pathExists categoryPath then
        map
          (file: categoryPath + "/${file}")
          (builtins.filter (f: builtins.match ".*\\.nix$" f != null)
            (builtins.attrNames (builtins.readDir categoryPath)))
      else
        []
    )
    [ "system" "desktop" ];
in
{
  imports = [ inputs.disko.nixosModules.disko ] ++ modulePaths;

  system.stateVersion = stateVersion;
  time.timeZone = "Africa/Cairo";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    use-xdg-base-directories = true;
    auto-optimise-store = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
  };
}

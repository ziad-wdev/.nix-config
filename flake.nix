{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock.url  = "github:Greeenman999/qylock-nix";

    firefox-addons.url = "github:ryantm/firefox-addons";
  };

  outputs = { nixpkgs, disko, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "ziad";
    sharedArgs = {
      username = username;
      inherit inputs;
    };
  in
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = system;

      # Pass sharedArg to NixOS configuration
      specialArgs = sharedArgs;

      modules = [
        # Main configuration modules
        disko.nixosModules.disko
        ./hosts/default/disko.nix
        ./hosts/default/hardware-configuration.nix
        ./hosts/default/configuration.nix
        ./hosts/default/packages.nix

        # Home Manager and sddm theme configuration
        home-manager.nixosModules.home-manager
        inputs.qylock.nixosModules.default # sddm qylock theme
        {
          programs.qylock = {
              enable = true;
              theme = "pixel-hollowknight";
              sddmTheme = "pixel-hollowknight";
          };

          home-manager = {
            # Pass sharedArg to Home Manager configuration
            extraSpecialArgs = sharedArgs;

            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              imports = [
                ./home/default/home.nix
              ];
            };
          };
        }
      ];
    };
  };
}

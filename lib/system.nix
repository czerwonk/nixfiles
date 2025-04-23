{ inputs, ... }:

{
  mkNixOSSystem =
    {
      configName,
      username,
      system,
      extraModules,
      extraHomeModules,
    }:
    let
      util = import ./util.nix;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../nixos/hosts/${configName}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules util;
            wrapFirejailBinary = import ./firejail.nix;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit
          configName
          username
          system
          inputs
          util
          ;
      };
    };

  mkNixOSSystemUnstable =
    {
      configName,
      username,
      system,
      extraModules,
      extraHomeModules,
    }:
    let
      util = import ./util.nix;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../nixos/hosts/${configName}/configuration.nix
        inputs.home-manager-unstable.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules util;
            wrapFirejailBinary = import ./firejail.nix;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit
          configName
          username
          system
          inputs
          util
          ;
      };
    };

  mkISO =
    {
      edition,
      baseModule,
      extraModules,
      extraHomeModules,
    }:
    let
      util = import ./util.nix;
    in
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        baseModule
        ../overlays.nix
        ../nixos/iso/${edition}
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ../nixos/iso/${edition}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs extraHomeModules util;
            username = "nixos";
            wrapFirejailBinary = import ./firejail.nix;
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit inputs util;
        system = "x86_64-linux";
        username = "nixos";
        configName = "iso";
      };
    };

  mkDarwinSystem =
    {
      configName,
      username,
      system,
      extraModules,
      extraHomeModules,
    }:
    let
      util = import ./util.nix;
    in
    inputs.darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../darwin/hosts/${configName}/configuration.nix
        inputs.home-manager-darwin.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../darwin/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules util;
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit
          configName
          username
          system
          inputs
          util
          ;
      };
    };
}

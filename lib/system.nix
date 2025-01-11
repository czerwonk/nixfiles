{ inputs, ... }:

{
  mkNixOSSystem = { configName, username, system, extraModules, extraHomeModules }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../nixos/hosts/${configName}/configuration.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit configName username system inputs;
      };
    };

  mkNixOSSystemUnstable = { configName, username, system, extraModules, extraHomeModules }:
    inputs.nixpkgs-unstable.lib.nixosSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../nixos/hosts/${configName}/configuration.nix
        inputs.home-manager-unstable.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit configName username system inputs;
      };
    };

  mkISO = { edition, baseModule, extraModules, extraHomeModules }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        baseModule
        ../overlays.nix
        ../nixos/iso/${edition}
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ../nixos/iso/${edition}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs extraHomeModules;
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit inputs;
        system = "x86_64-linux";
        username = "nixos";
        configName = "iso";
      };
    };

  mkDarwinSystem = { configName, username, system, extraModules, extraHomeModules }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ../overlays.nix
        ../darwin/hosts/${configName}/configuration.nix
        inputs.home-manager-darwin.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../darwin/hosts/${configName}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules;
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit configName username system inputs;
      };
    };
}

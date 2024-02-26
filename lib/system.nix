{ inputs, ... }:

{
  mkNixOSSystem = { hostname, domain, username, system, extraModules, extraHomeModules }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../overlays.nix
        ../nixos/hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${hostname}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit username hostname domain system inputs;
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
        hostname = "nixos";
        domain = "";
      };
    };
}

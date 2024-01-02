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
            inherit username extraHomeModules system inputs;
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit username hostname domain system inputs;
      };
    };
}

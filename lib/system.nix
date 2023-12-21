{ inputs, overlays, ... }:

{
  mkNixOSSystem = { hostname, domain, username, extraModules, extraHomeModules }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../nixos/hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${hostname}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules inputs;
            pkgs-unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config = { allowUnfree = true; };
              overlays = overlays;
            };
          };
        }
        inputs.impermanence.nixosModule
      ] ++ extraModules;
      specialArgs = {
        inherit username hostname domain inputs;
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      };
    };
}

{ home-manager, nixpkgs, nixpkgs-unstable, ... }:

{
  mkNixOSSystem = { hostname, domain, username, extraModules, extraHomeModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../nixos/hosts/${hostname}/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/hosts/${hostname}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username extraHomeModules;
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config = { allowUnfree = true; };
            };
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit username hostname domain;
      };
    };
}

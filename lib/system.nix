{ home-manager, nixpkgs, ... }:

{
  mkNixOSSystem = {hostname, username, signingkey, workspace, extraModules, extraHomeModules}:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/${hostname}/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../nixos/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username signingkey workspace extraHomeModules;
          };
        }
      ] ++ extraModules;
      specialArgs = {
        inherit username;
      };
    };
}

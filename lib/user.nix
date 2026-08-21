{ inputs, ... }:

{
  mkLinuxHMUser =
    { username, extraModules }:
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ../overlays
        ../home/linux.nix
      ]
      ++ extraModules;
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
      };
      extraSpecialArgs = {
        inherit username inputs;
        system = "x86_64-linux";
        util = import ./util.nix;
      };
    };
}

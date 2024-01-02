{ inputs, ... }:

{
  mkOSXHMUser = { username, extraModules }:
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ../overlays.nix
        ../home/osx
      ] ++ extraModules;
      pkgs = import inputs.nixpkgs {
        system = "x86_64-darwin";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username inputs;
        system = "x86_64-darwin";
      };
    };

  mkLinuxHMUser = {username, extraModules}:
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ../overlays.nix
        ../home/linux.nix
      ] ++ extraModules;
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username inputs;
        system = "x86_64-linux";
      };
    };
}

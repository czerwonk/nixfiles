{ inputs, ... }:

{
  mkOSXHMUser = { username, extraModules }:
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
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

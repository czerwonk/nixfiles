{ home-manager, nixpkgs, ... }:

{
  mkOSXHMUser = {username, extraModules}:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        ../home/osx.nix
      ] ++ extraModules;
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username;
      };
    };

  mkLinuxHMUser = {username, extraModules}:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        ../home/linux.nix
      ] ++ extraModules;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username;
      };
    };
}

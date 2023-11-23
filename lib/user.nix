{ home-manager, nixpkgs, nixpkgs-unstable, overlays, ... }:

{
  mkOSXHMUser = { username, extraModules }:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        ../home/osx
      ] ++ extraModules;
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config = { allowUnfreePredicate = pkg: true;};
        overlays = overlays;
      };
      extraSpecialArgs = {
        inherit username;
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-darwin";
          config = { allowUnfree = true; };
          overlays = overlays;
        };
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
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      };
    };
}

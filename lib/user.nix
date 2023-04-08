{ home-manager, nixpkgs, ... }:

{
  mkOSXHMUser = {username, signingkey, workspace, extraModules}:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        ../osx/home.nix
      ] ++ extraModules;
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username signingkey workspace;
      };
    };

  mkLinuxHMUser = {username, signingkey, workspace, extraModules}:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        ../linux/home.nix
      ] ++ extraModules;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfreePredicate = pkg: true;};
      };
      extraSpecialArgs = {
        inherit username signingkey workspace;
      };
    };
}

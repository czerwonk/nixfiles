{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      util = import ./lib {
        inherit home-manager nixpkgs;
      };
      inherit (util) userUtil;
      inherit (util) systemUtil;

      mauve = builtins.fetchGit {
        url = "git@github.com:czerwonk/mauve.nixfiles.git";
        ref = "main";
        rev = "8766bfad1d88347d22e547abb1f7274467345d2a";
      };
      mauveUtil = import mauve {
        inherit home-manager nixpkgs;
      };
      inherit (mauveUtil) mauveUserUtil;

      username = "daniel";

    in {
      homeConfigurations = {
        "${username}-osx" = userUtil.mkOSXHMUser {
          inherit username;
          extraModules = [ 
            ./home-manager/presets/devops
          ];
        };

        "${username}-linux" = userUtil.mkLinuxHMUser {
          inherit username;
          extraModules = [ 
            ./home-manager/presets/devops
          ];
        };

        "${username}-osx-mauve" = mauveUserUtil.mkOSXHMUserProfile {
          extraModules = [ 
            ./osx
            ./home-manager/presets/devops
          ];
        };

        "mauve-osx" = mauveUserUtil.mkOSXHMUser {
          extraModules = [ 
            ./osx
            ./home-manager/presets/devops
          ];
        };

        "mauve-linux" = mauveUserUtil.mkLinuxHMUser {
          extraModules = [ 
            ./linux
            ./home-manager/presets/devops/dev.nix
          ];
        };
      };

      nixosConfigurations = {
        dan-x1 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "dan-x1";
          extraModules = [
            ./nixos/pentest
          ];
          extraHomeModules = [
            ./home-manager/presets/devops
            ./home-manager/presets/pentest
          ];
        };
      };
    };
}

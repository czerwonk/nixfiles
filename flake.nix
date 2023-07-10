{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let
      util = import ./lib {
        inherit home-manager nixpkgs nixpkgs-unstable;
      };
      inherit (util) userUtil;
      inherit (util) systemUtil;

      mauve = builtins.fetchGit {
        url = "git@github.com:czerwonk/mauve.nixfiles.git";
        ref = "main";
        rev = "393ed4c6f836fca6a8ab52f5093d22908eb0c4a8";
      };
      mauveUtil = import mauve {
        inherit home-manager nixpkgs nixpkgs-unstable;
      };
      inherit (mauveUtil) mauveUserUtil;

      routingRocks = builtins.fetchGit {
        url = "git@github.com:czerwonk/routing-rocks.nixfiles.git";
        ref = "main";
        rev = "5096692cee128b4433d2eaedaa0e4ddb55f58ae1";
      };

      username = "daniel";

    in {
      homeConfigurations = {
        "${username}-osx" = userUtil.mkOSXHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
          ];
        };

        "${username}-linux" = userUtil.mkLinuxHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
          ];
        };

        "${username}-osx-mauve" = mauveUserUtil.mkOSXHMUserProfile {
          extraModules = [
            ./home/osx
            ./home/suits/devops
          ];
        };

        "mauve-osx" = mauveUserUtil.mkOSXHMUser {
          extraModules = [
            ./home/osx
            ./home/suits/devops
          ];
        };

        "mauve-linux" = mauveUserUtil.mkLinuxHMUser {
          extraModules = [ 
            ./home/linux.nix
            ./home/suits/devops/dev.nix
          ];
        };
      };

      nixosConfigurations = {
        dan-x1 = systemUtil.mkNixOSSystem {
          inherit username routingRocks;
          hostname = "dan-x1";
          extraHomeModules = [
            ./home/suits/devops
            ./home/suits/pentest
          ];
        };
        bb1 = systemUtil.mkNixOSSystem {
          inherit username routingRocks;
          hostname = "bb1";
          extraHomeModules = [
            ./home/suits/devops
          ];
        };
      };
    };
}

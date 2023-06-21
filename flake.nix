{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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
        rev = "181f26e83099ee9398aac5e2ed68905679b7266c";
      };
      mauveUtil = import mauve {
        inherit home-manager nixpkgs;
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

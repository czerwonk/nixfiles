{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thinkpad-fprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, thinkpad-fprint-sensor, ... }:
    let
      util = import ./lib {
        inherit home-manager nixpkgs nixpkgs-unstable;
      };
      inherit (util) userUtil;
      inherit (util) systemUtil;

      mauveModule = builtins.fetchGit {
        url = "git@github.com:czerwonk/mauve.nixfiles.git";
        ref = "main";
        rev = "faa077fa194bf4bfa41e3338dda594a78c375636";
      };
      mauve = import mauveModule;

      routingRocks = builtins.fetchGit {
        url = "git@github.com:czerwonk/routing-rocks.nixfiles.git";
        ref = "main";
        rev = "5096692cee128b4433d2eaedaa0e4ddb55f58ae1";
      };

      username = "daniel";

    in {
      homeConfigurations = {
        "osx" = userUtil.mkOSXHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
            mauve.home
          ];
        };

        "linux" = userUtil.mkLinuxHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
          ];
        };

        "mauve-osx" = userUtil.mkOSXHMUser {
          username = mauve.username {};
          extraModules = [
            ./home/suits/devops
            mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };

        "mauve-linux" = userUtil.mkLinuxHMUser {
          username = mauve.username {};
          extraModules = [ 
            ./home/suits/devops/dev.nix
            mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };
      };

      nixosConfigurations = {
        dan-x1 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "dan-x1";
          extraModules = [
            thinkpad-fprint-sensor.nixosModules.open-fprintd
            thinkpad-fprint-sensor.nixosModules.python-validity
          ];
          extraHomeModules = [
            ./home/suits/devops
            ./home/suits/pentest
            mauve.home
          ];
        };
        bb1 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "bb1";
          extraModules = [
            (import routingRocks)
          ];
          extraHomeModules = [
            ./home/suits/devops
          ];
        };
        bb2 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "bb2";
          extraModules = [
            (import routingRocks)
          ];
          extraHomeModules = [
            ./home/suits/devops
          ];
        };
        surf-vm = systemUtil.mkNixOSSystem {
          username = "user";
          hostname = "surf-vm";
          extraModules = [];
          extraHomeModules = [];
        };
      };
    };
}

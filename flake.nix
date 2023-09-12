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
      inputs.nixpkgs.follows = "nixpkgs";
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
        rev = "060f2847642eef9e1a53bc1e4143a6cb967a94d1";
      };
      mauve = import mauveModule;

      routingRocks = builtins.fetchGit {
        url = "git@github.com:czerwonk/routing-rocks.nixfiles.git";
        ref = "main";
        rev = "7e2d0fce20b56db98bc8e5e355061a924fdcf375";
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
          domain = "routing.rocks";
          extraModules = [
            thinkpad-fprint-sensor.nixosModules.open-fprintd
            thinkpad-fprint-sensor.nixosModules.python-validity
            (import routingRocks)
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
          domain = "dus.routing.rocks";
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
          domain = "dus.routing.rocks";
          extraModules = [
            (import routingRocks)
          ];
          extraHomeModules = [
            ./home/suits/devops
          ];
        };
        surf-vm = systemUtil.mkNixOSSystem {
          username = "user";
          domain = "";
          hostname = "surf-vm";
          extraModules = [];
          extraHomeModules = [];
        };
      };
    };
}

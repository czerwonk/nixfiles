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

    impermanence.url = "github:nix-community/impermanence";

    private.url = "git+ssh://git@github.com/czerwonk/nixfiles.private";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, private, thinkpad-fprint-sensor, impermanence, ... }:
    let
      util = import ./lib {
        inherit home-manager nixpkgs nixpkgs-unstable impermanence;
      };
      inherit (util) userUtil;
      inherit (util) systemUtil;

      username = "daniel";

    in {
      homeConfigurations = {
        "osx" = userUtil.mkOSXHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
            private.mauve.home
          ];
        };

        "linux" = userUtil.mkLinuxHMUser {
          inherit username;
          extraModules = [
            ./home/suits/devops
          ];
        };

        "mauve-osx" = userUtil.mkOSXHMUser {
          username = private.mauve.username {};
          extraModules = [
            ./home/suits/devops
            private.mauve.home
            {
              private.mauve.overrides.git = true;
            }
          ];
        };

        "mauve-linux" = userUtil.mkLinuxHMUser {
          username = private.mauve.username {};
          extraModules = [ 
            ./home/suits/devops/dev.nix
            private.mauve.home
            {
              private.mauve.overrides.git = true;
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
            private.nixosModule
          ];
          extraHomeModules = [
            private.mauve.home
          ];
        };
        bb1 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "bb1";
          domain = "dus.routing.rocks";
          extraModules = [
            private.nixosModule
          ];
          extraHomeModules = [];
        };
        bb2 = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "bb2";
          domain = "dus.routing.rocks";
          extraModules = [
            private.nixosModule
          ];
          extraHomeModules = [];
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

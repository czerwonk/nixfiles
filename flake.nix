{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    thinkpad-fprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    private.url = "git+ssh://git@github.com/czerwonk/nixfiles.private";
  };

  outputs = { nixpkgs, 
              home-manager, 
              nixpkgs-unstable, 
              private, 
              nixos-hardware, 
              thinkpad-fprint-sensor, 
              impermanence, ... }:
    let
      userLib = import ./lib/user.nix {
        inherit home-manager nixpkgs nixpkgs-unstable;
      };
      systemLib = import ./lib/system.nix {
        inherit home-manager nixpkgs nixpkgs-unstable impermanence;
      };

    in {
      homeConfigurations = {
        "osx" = userLib.mkOSXHMUser {
          username = private.username {};
          extraModules = [
            ./home/suits/devops
            private.home
            private.mauve.home
          ];
        };

        "linux" = userLib.mkLinuxHMUser {
          username = private.username {};
          extraModules = [
            ./home/suits/devops
            private.home
          ];
        };

        "mauve-osx" = userLib.mkOSXHMUser {
          username = private.mauve.username {};
          extraModules = [
            ./home/suits/devops
            private.home
            private.mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };

        "mauve-linux" = userLib.mkLinuxHMUser {
          username = private.mauve.username {};
          extraModules = [ 
            ./home/suits/devops/dev.nix
            private.home
            private.mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };
      };

      nixosConfigurations = {
        dan-x1 = systemLib.mkNixOSSystem {
          username = private.username {};
          hostname = "dan-x1";
          domain = "routing.rocks";
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
            thinkpad-fprint-sensor.nixosModules.open-fprintd
            thinkpad-fprint-sensor.nixosModules.python-validity
            private.nixosModule
          ];
          extraHomeModules = [
            private.home
            private.mauve.home
          ];
        };
        bb1 = systemLib.mkNixOSSystem {
          username = private.username {};
          hostname = "bb1";
          domain = "dus.routing.rocks";
          extraModules = [
            private.nixosModule
          ];
          extraHomeModules = [
            private.home
          ];
        };
        bb2 = systemLib.mkNixOSSystem {
          username = private.username {};
          hostname = "bb2";
          domain = "dus.routing.rocks";
          extraModules = [
            private.nixosModule
          ];
          extraHomeModules = [
            private.home
          ];
        };
        surf-vm = systemLib.mkNixOSSystem {
          username = "user";
          domain = "";
          hostname = "surf-vm";
          extraModules = [];
          extraHomeModules = [];
        };
      };
    };
}

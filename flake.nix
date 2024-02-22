{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    thinkpad-fprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    private.url = "git+ssh://git@code.routing.rocks/daniel/nixfiles.private";

    routing-rocks-policy.url = "github:czerwonk/routing-rocks-policy-role";

    ansible-role.url = "github:czerwonk/ansible-role";

    dns-drain.url = "github:czerwonk/dns-drain";

    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = inputs:
    let
      userLib = import ./lib/user.nix {
        inherit inputs;
      };
      systemLib = import ./lib/system.nix {
        inherit inputs;
      };

    in {
      homeConfigurations = {
        "osx" = userLib.mkOSXHMUser {
          username = inputs.private.username {};
          extraModules = [
            ./home/suits/devops
            inputs.private.home
            inputs.private.mauve.home
          ];
        };

        "mauve-linux" = userLib.mkLinuxHMUser {
          username = inputs.private.mauve.username {};
          extraModules = [ 
            ./home/suits/server
            ./home/suits/devops/dev.nix
            inputs.private.home
            inputs.private.mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };
      };

      nixosConfigurations = {
        scrapy = systemLib.mkNixOSSystem {
          username = inputs.private.username {};
          hostname = "scrapy";
          domain = "routing.rocks";
          system = "x86_64-linux";
          extraModules = [
            inputs.private.nixosModule
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
            {
              services.fprintd.tod.enable = true;
              services.fprintd.tod.driver = inputs.thinkpad-fprint-sensor.lib.libfprint-2-tod1-vfs0090-bingch {
                calib-data-file = ./nixos/hosts/scrapy/calib-data.bin;
              };
            }
          ];
          extraHomeModules = [
            inputs.private.home
            inputs.private.mauve.home
          ];
        };
        framy = systemLib.mkNixOSSystem {
          username = inputs.private.username {};
          hostname = "framy";
          domain = "routing.rocks";
          system = "x86_64-linux";
          extraModules = [
            inputs.private.nixosModule
            inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ];
          extraHomeModules = [
            inputs.private.home
            inputs.private.mauve.home
          ];
        };
        bb1 = systemLib.mkNixOSSystem {
          username = inputs.private.username {};
          hostname = "bb1";
          domain = "dus.routing.rocks";
          system = "x86_64-linux";
          extraModules = [
            inputs.private.nixosModule
            inputs.routing-rocks-policy.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        bb2 = systemLib.mkNixOSSystem {
          username = inputs.private.username {};
          hostname = "bb2";
          domain = "dus.routing.rocks";
          system = "x86_64-linux";
          extraModules = [
            inputs.private.nixosModule
            inputs.routing-rocks-policy.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        homey = systemLib.mkNixOSSystem {
          username = inputs.private.username {};
          hostname = "homey";
          domain = "ess.routing.rocks";
          system = "x86_64-linux";
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        surf-vm = systemLib.mkNixOSSystem {
          username = "user";
          hostname = "surf-vm";
          domain = "";
          system = "x86_64-linux";
          extraModules = [];
          extraHomeModules = [];
        };
      };
    };
}

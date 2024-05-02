{
  description = "Daniel Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    thinkpad-fprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crowdsec = {
      url = "github:czerwonk/nix-flake-crowdsec";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    private.url = "git+ssh://git@code.routing.rocks/daniel/nixfiles.private";

    routing-rocks-policy.url = "github:czerwonk/routing-rocks-policy-role";

    ansible-role.url = "github:czerwonk/ansible-role";

    dns-drain.url = "github:czerwonk/dns-drain";

    provisionize.url = "github:MauveSoftware/provisionize";
  };

  outputs = inputs:
    let
      userLib = import ./lib/user.nix {
        inherit inputs;
      };
      systemLib = import ./lib/system.nix {
        inherit inputs;
      };

      system = "x86_64-linux";

    in {
      homeConfigurations = {
        "osx" = userLib.mkOSXHMUser {
          username = inputs.private.username {};
          extraModules = [
            ./home/profiles/devops
            inputs.private.home
            inputs.private.mauve.home
          ];
        };

        "mauve-linux" = userLib.mkLinuxHMUser {
          username = inputs.private.mauve.username {};
          extraModules = [ 
            ./home/profiles/server
            ./home/profiles/devops/dev.nix
            inputs.private.home
            inputs.private.mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };
      };

      nixosConfigurations = {
        framy = systemLib.mkNixOSSystem {
          configName = "framy";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
            inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ];
          extraHomeModules = [
            inputs.private.home
            inputs.private.mauve.home
          ];
        };
        bb1-dus = systemLib.mkNixOSSystem {
          configName = "bb1-dus";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
            inputs.routing-rocks-policy.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        bb2-dus = systemLib.mkNixOSSystem {
          configName = "bb2-dus";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
            inputs.routing-rocks-policy.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        homey = systemLib.mkNixOSSystem {
          configName = "homey";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        backup1-ess = systemLib.mkNixOSSystem {
          configName = "backup1-ess";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        backup1-wup = systemLib.mkNixOSSystem {
          configName = "backup1-wup";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        scrapy = systemLib.mkNixOSSystem {
          configName = "scrapy";
          inherit system;
          username = inputs.private.username {};
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
        surf-vm = systemLib.mkNixOSSystem {
          configName = "surf-vm";
          inherit system;
          username = "user";
          extraModules = [];
          extraHomeModules = [];
        };
        iso-minimal = systemLib.mkISO {
          edition = "minimal";
          baseModule = "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        iso-gnome = systemLib.mkISO {
          edition = "gnome";
          baseModule = "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix";
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
      };
    };
}

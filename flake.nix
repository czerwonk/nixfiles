{
  description = "Daniel Brendgen-Czerwonk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    crowdsec = {
      url = "github:czerwonk/nix-flake-crowdsec";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence?ref=d000479f4f41390ff7cf9204979660ad5dd16176";

    private.url = "git+ssh://git@code.routing.rocks/daniel/nixfiles.private";

    routing-rocks-policy.url = "github:czerwonk/routing-rocks-policy-role";

    ansible-role.url = "github:czerwonk/ansible-role";

    dns-drain.url = "github:czerwonk/dns-drain";

    net-merge.url = "github:czerwonk/net-merge";

    blink-cmp.url = "github:Saghen/blink.cmp?ref=1cc3b1a908fbcfd15451c4772759549724f38524";

    ghostty.url = "github:ghostty-org/ghostty?ref=3f7c3afaf947280bd2852626ff4599c02d9fb07e";
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
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = { allowUnfreePredicate = pkg: true;};
      };

    in {
      homeConfigurations = {
        "mauve-linux" = userLib.mkLinuxHMUser {
          username = inputs.private.mauve.username {};
          extraModules = [ 
            ./home/profiles/server
            ./home/profiles/devops
            inputs.private.home
            inputs.private.mauve.home
            {
              mauve.overrides.git = true;
            }
          ];
        };
      };

      nixosConfigurations = {
        kyoto = systemLib.mkNixOSSystem {
          configName = "kyoto";
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
        home1 = systemLib.mkNixOSSystem {
          configName = "home1";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        home2 = systemLib.mkNixOSSystem {
          configName = "home2";
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
            inputs.routing-rocks-policy.nixosModule
          ];
          extraHomeModules = [
            inputs.private.home
          ];
        };
        osaka = systemLib.mkNixOSSystem {
          configName = "osaka";
          inherit system;
          username = inputs.private.username {};
          extraModules = [
            inputs.private.nixosModule
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

      darwinConfigurations = {
        nara = systemLib.mkDarwinSystem {
          configName = "nara";
          system = "x86_64-darwin";
          username = inputs.private.username {};
          extraModules = [];
          extraHomeModules = [
            inputs.private.home
            inputs.private.mauve.home
          ];
        };
      };

      devShells.${system} = {
        debug = import ./shell/debug/shell.nix { inherit pkgs; };
        gstreamer = import ./shell/gstreamer/shell.nix { inherit pkgs; };
        javafx = import ./shell/javafx/shell.nix { inherit pkgs; };
        javaws = import ./shell/javaws/shell.nix { inherit pkgs; };
        pdf-merge = import ./shell/pdf-merge/shell.nix { inherit pkgs; };
        pentest = import ./shell/pentest/shell.nix { inherit pkgs; };
        performance-disk = import ./shell/performance/disk/shell.nix { inherit pkgs; };
      };
    };
}

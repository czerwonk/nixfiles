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
        rev = "181f26e83099ee9398aac5e2ed68905679b7266c";
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
            ./home/presets/devops
          ];
        };

        "${username}-linux" = userUtil.mkLinuxHMUser {
          inherit username;
          extraModules = [ 
            ./home/presets/devops
          ];
        };

        "${username}-osx-mauve" = mauveUserUtil.mkOSXHMUserProfile {
          extraModules = [ 
            ./home/osx.nix
            ./home/presets/devops
          ];
        };

        "mauve-osx" = mauveUserUtil.mkOSXHMUser {
          extraModules = [ 
            ./home/osx.nix
            ./home/presets/devops
          ];
        };

        "mauve-linux" = mauveUserUtil.mkLinuxHMUser {
          extraModules = [ 
            ./home/linux.nix
            ./home/presets/devops/dev.nix
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
            ./home/presets/devops
            ./home/presets/pentest
          ];
        };
      };
    };
}

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
        rev = "66cc09da3cfc92194ffb34ce08077916ce1d4530";
      };
      mauveUtil = import mauve {
        inherit home-manager nixpkgs;
      };
      inherit (mauveUtil) mauveUserUtil;

      username = "daniel";
      signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC5NEvD6tPxgg2MrQpJz6bl0gac3iJEJ6FKT2yebj5aYP30lTogZiyCTfTls30SkeNKfUkEjlIrF6ShfVcry/VTsZyARXYCv1NJcvdHcpvuufvuhlfzhmD0vnp/VVZbhuLyILzBOdGjJ7eBT886m3GkOG1EYw7HA+XZFLbrEdQMcASSBQaULhhWSZI0s1W8hiG7Jg8cMdgjJkhQALTKkfOmV/FzZ4ZS6OLspBrPxUxIwKUyYhGJ54KCvhQ8eV3av7x87cwMUc/gBhpI2upq86U+wVSBPkUt1GNHrQLVpAQ5cBut4BhKMU9w+B71TEIcPSSNwy3Efv5x3gSkGEDzU2AVc0KQyBTs38IWGB1UXEGTtbVI9JzAoDNJjjGXqOClgLc7Quyv58CabzhlELtPUtIqoRJGggiwhYJ7oiPbNkBDe+AfIWIbCwIunShmxQA+5oeAuZGOgLCPoryyjzyvKHx4W/jESvbji3YACZ2362UcoJOx6yNlE6Bhvo8+y3fUvjQjqgOXR2siMWVUuhXfzJsFYMBtA2R5NgqioWqveGmgBbeW+mG/X91f09ZEm5Edn6VYK4FAGJFizVdadp15KlgUPFUuS+6q/i5rXMjeQCnC6anXjPHJQpSYgmoZjjgI9WUGkGoqwSxmCfgEBg5rI9JW38TqEt0Z4gjZ6ViRee2Sw==";
      workspace = "";

    in {
      homeConfigurations = {
        "${username}-osx" = userUtil.mkOSXHMUser {
          inherit username signingkey workspace;
          extraModules = [ 
            ./home/devops
            ./home/profiles/default
          ];
        };

        "${username}-linux" = userUtil.mkLinuxHMUser {
          inherit username signingkey workspace;
          extraModules = [ 
            ./home/devops
            ./home/profiles/default
          ];
        };

        "${username}-osx-mauve" = mauveUserUtil.mkOSXHMUserProfile {
          extraModules = [ 
            ./osx/home.nix
            ./home/devops
            ./home/profiles/default/ssh.nix
          ];
        };

        "mauve-osx" = mauveUserUtil.mkOSXHMUser {
          extraModules = [ 
            ./osx/home.nix
            ./home/devops
            ./home/profiles/default/ssh.nix
          ];
        };

        "mauve-linux" = mauveUserUtil.mkLinuxHMUser {
          extraModules = [ 
            ./linux/home.nix
            ./home/devops/dev.nix
            ./home/profiles/default/ssh.nix
          ];
        };
      };

      nixosConfigurations = {
        dan-x1 = systemUtil.mkNixOSSystem {
          inherit username workspace;
          hostname = "dan-x1";
          signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCntn+hhu24ebIaemRkZehp57IxFcOIwAfD6lELC1REZpHWEgZ685xiqJPai5Gp9gt17oAut1FEayJd6ZOYKPXNDS1Bm6E0EDSVpVHUPiVivcfYMSmRknti5I+BnkJRzy79gbN66e5TByzVir1gIqJSEorfYyA4rx3DFDtFtl6Bbq1UswR/g4RowxIAwMjj8MYesOw612khRg53fxOMniVpsd9ULqstBg1iOvfkKJhoU7pyYkZWIkka96cLcuw6ZX+u18is5eTrldo6oRT7A6ujgDy6wpJ3dvDR0EK12koBMcwrwcYeQyCHUzR4Bo89gXtRfLeHSjW2vUXPm+OXsu31Hb50KH+M/CPGXOUDBS//8vqVv3QZ02sbcFLxZiOPEPnKfruqakWNE9iYHQDa521YQj/XKJ73AytAym/vqzK5usqmQpSUM3D0fWWAec75n4EG9rUMVJ4WzkYI30uqkp7gzBWD0aeFPVY7dVUVTx8+iiTTft7JnTzkFxdUxm7s0cZMKYPqNpeYDfS1OyFnw1HjHMXnOCDoEKM7DUu7ioGu5CrkqjwsmqHHSQS9CVc9qQNebYIyOu6oL1mDbxGf5bZlkGMECAnkaFYNEwJF2IACzLVpM3txSGdX2GqgM/4kU9mce4gmzt6Pz+0LP3TF9oT8voRQ3KTnSuRv1PrBXzx2RQ==";
          extraModules = [];
          extraHomeModules = [
            ./home/profiles/mauve/ssh.nix
          ];
        };

        dan-x1-pentest = systemUtil.mkNixOSSystem {
          inherit username;
          hostname = "dan-x1";
          workspace = "PENTEST";
          signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCntn+hhu24ebIaemRkZehp57IxFcOIwAfD6lELC1REZpHWEgZ685xiqJPai5Gp9gt17oAut1FEayJd6ZOYKPXNDS1Bm6E0EDSVpVHUPiVivcfYMSmRknti5I+BnkJRzy79gbN66e5TByzVir1gIqJSEorfYyA4rx3DFDtFtl6Bbq1UswR/g4RowxIAwMjj8MYesOw612khRg53fxOMniVpsd9ULqstBg1iOvfkKJhoU7pyYkZWIkka96cLcuw6ZX+u18is5eTrldo6oRT7A6ujgDy6wpJ3dvDR0EK12koBMcwrwcYeQyCHUzR4Bo89gXtRfLeHSjW2vUXPm+OXsu31Hb50KH+M/CPGXOUDBS//8vqVv3QZ02sbcFLxZiOPEPnKfruqakWNE9iYHQDa521YQj/XKJ73AytAym/vqzK5usqmQpSUM3D0fWWAec75n4EG9rUMVJ4WzkYI30uqkp7gzBWD0aeFPVY7dVUVTx8+iiTTft7JnTzkFxdUxm7s0cZMKYPqNpeYDfS1OyFnw1HjHMXnOCDoEKM7DUu7ioGu5CrkqjwsmqHHSQS9CVc9qQNebYIyOu6oL1mDbxGf5bZlkGMECAnkaFYNEwJF2IACzLVpM3txSGdX2GqgM/4kU9mce4gmzt6Pz+0LP3TF9oT8voRQ3KTnSuRv1PrBXzx2RQ==";
          extraModules = [
            ./nixos/pentest.nix
          ];
          extraHomeModules = [
            ./home/pentest/home.nix
          ];
        };
      };
    };
}

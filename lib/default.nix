{ home-manager, nixpkgs, nixpkgs-unstable, ... }:

rec {
  userUtil = import ./user.nix { inherit home-manager nixpkgs nixpkgs-unstable; };
  systemUtil = import ./system.nix { inherit home-manager nixpkgs nixpkgs-unstable; };
}

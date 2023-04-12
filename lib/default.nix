{ home-manager, nixpkgs, ... }:

rec {
  userUtil = import ./user.nix { inherit home-manager nixpkgs; };
  systemUtil = import ./system.nix { inherit home-manager nixpkgs; };
}

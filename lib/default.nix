{ home-manager, nixpkgs, nixpkgs-unstable, impermanence, ... }:

{
  userUtil = import ./user.nix { inherit home-manager nixpkgs nixpkgs-unstable; };
  systemUtil = import ./system.nix { inherit home-manager nixpkgs nixpkgs-unstable impermanence; };
}

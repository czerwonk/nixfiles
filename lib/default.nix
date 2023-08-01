{ home-manager, nixpkgs, nixpkgs-unstable, ... }:

{
  userUtil = import ./user.nix { inherit home-manager nixpkgs nixpkgs-unstable; };
  systemUtil = import ./system.nix { inherit home-manager nixpkgs nixpkgs-unstable; };
}

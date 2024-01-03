{ system, inputs, pkgs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };

  nix-alien-packages = inputs.nix-alien.packages.${system};

in {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nixpkgs.overlays = [
    (self: super: {
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
      vimPlugins = pkgs-unstable.vimPlugins;
      nix-alien = nix-alien-packages.nix-alien;
      kanagawa-gtk-theme = pkgs.callPackage ./pkgs/kanagawa-gtk-theme {};
      ansible-role = pkgs.callPackage ./pkgs/ansible-role {};
      dns-drain = pkgs.callPackage ./pkgs/dns-drain {};
    })
  ];
}

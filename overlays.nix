{ system, inputs, pkgs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
    overlays = [
      (self: super: {
        netavark = pkgs.callPackage ./pkgs/netavark {};
      })
    ];
  };

  nix-alien-packages = inputs.nix-alien.packages.${system};

in {
  nixpkgs.overlays = [
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
      sublime4 = pkgs-unstable.sublime4;
      brave = pkgs-unstable.brave;
      unifi = pkgs-unstable.unifi8;
      vimPlugins = pkgs-unstable.vimPlugins;
      nix-alien = nix-alien-packages.nix-alien;
      kanagawa-gtk-theme = pkgs.callPackage ./pkgs/kanagawa-gtk-theme {};
      ansible-role = pkgs.callPackage ./pkgs/ansible-role {};
      dns-drain = pkgs.callPackage ./pkgs/dns-drain {};
      provisionize = pkgs.callPackage ./pkgs/provisionize {};
    })
  ];
}

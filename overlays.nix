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
  };

  ansible-role-packages = inputs.ansible-role.packages.${system};
  nix-alien-packages = inputs.nix-alien.packages.${system};

in {
  nixpkgs.overlays = [
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      ansible-role = ansible-role-packages.ansible-role;
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
      go = pkgs-unstable.go_1_22;
      sublime4 = pkgs-unstable.sublime4;
      brave = pkgs-unstable.brave;
      unifi = pkgs-unstable.unifi8;
      vimPlugins = super.vimPlugins // {
        neotest = pkgs-unstable.vimPlugins.neotest;
      };
      nix-alien = nix-alien-packages.nix-alien;
      kanagawa-gtk-theme = pkgs.callPackage ./pkgs/kanagawa-gtk-theme {};
      dns-drain = pkgs.callPackage ./pkgs/dns-drain {};
      provisionize = pkgs.callPackage ./pkgs/provisionize {};
    })
  ];
}

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
  dns-drain-packages = inputs.dns-drain.packages.${system};
  nix-alien-packages = inputs.nix-alien.packages.${system};
  provisionize-packages = inputs.provisionize.packages.${system};

in {
  nixpkgs.overlays = [
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      go = pkgs-unstable.go_1_22;
      nix-alien = nix-alien-packages.nix-alien;
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
      provisionize = provisionize-packages.provisionize;
      sublime4 = pkgs-unstable.sublime4;
      unifi = pkgs-unstable.unifi8;
      vimPlugins = super.vimPlugins // {
        neotest = pkgs-unstable.vimPlugins.neotest;
      };
    })
    (self: super: {
      gnome = super.gnome.overrideScope' (gfinal: gprev: {
        gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
          configureFlags = oldAttrs.configureFlags or [ ] ++ [
            "--disable-ssh-agent"
          ];
        });
      });
    })
  ];
}

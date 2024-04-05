{ system, inputs, ... }:

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
  hyprland-packages = inputs.hyprland.packages.${system};

in {
  nixpkgs.overlays = [
    (self: super: {
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = pkgs-unstable.callPackage ./pkgs/ethr {};
      hyprland = hyprland-packages.hyprland;
      hyprland-protocols = hyprland-packages.hyprland-protocols;
      nix-alien = nix-alien-packages.nix-alien;
      provisionize = provisionize-packages.provisionize;
      wlroots-hyprland = hyprland-packages.wlroots-hyprland;
      xdg-desktop-portal-hyprland = hyprland-packages.xdg-desktop-portal-hyprland;
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      bitwarden-cli = pkgs-unstable.bitwarden-cli;
      crowdsec = pkgs-unstable.crowdsec.overrideAttrs (old: {
        ldflags =
          (old.ldflags or [])
          ++ [
            "-X github.com/crowdsecurity/go-cs-lib/version.Version=v${old.version}"
          ];
        patches =
          (old.patches or [])
          ++ [
            (
              pkgs-unstable.fetchpatch
              {
                url = "https://patch-diff.githubusercontent.com/raw/crowdsecurity/crowdsec/pull/2868.patch";
                hash = "sha256-KLoGgHGwkS3+e0vSrivL0HQVRCCZ+saH9NDWlH7/Zmw=";
              }
            )
          ];
      });
      go = pkgs-unstable.go;
      k3s = pkgs-unstable.k3s;
      kubevirt = pkgs-unstable.kubevirt;
      neovim = pkgs-unstable.neovim;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      omnisharp-roslyn = pkgs-unstable.omnisharp-roslyn;
      podman = pkgs-unstable.podman;
      sublime4 = pkgs-unstable.sublime4;
      unifi = pkgs-unstable.unifi8;
      vimPlugins = pkgs-unstable.vimPlugins // {
        obsidian-nvim = pkgs-unstable.callPackage ./pkgs/obsidian-nvim {};
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

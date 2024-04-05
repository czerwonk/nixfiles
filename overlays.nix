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
  nvim-dap-ui = pkgs-unstable.vimUtils.buildVimPlugin {
    pname = "nvim-dap-ui";
    version = "2024-02-17";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-dap-ui";
      rev = "9720eb5fa2f41988e8770f973cd11b76dd568a5d";
      sha256 = "0ahc1f2h9qv6bns5mh7m90lfrf3yldy018p27dsc9cgpdpb15i1q";
    };
    meta.homepage = "https://github.com/rcarriga/nvim-dap-ui/";
  };
  obsidian-nvim = pkgs-unstable.vimUtils.buildVimPlugin {
    pname = "obsidian.nvim";
    version = "v2.5";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "88bf9150d9639a2cae3319e76abd7ab6b30d27f0";
      hash = "sha256-irPk9iprbI4ijNUjMxXjw+DljudZ8aB3f/FJxXhFSoA=";
    };
    meta.homepage = "https://github.com/epwalsh/obsidian.nvim/";
  };

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
        nvim-dap-ui = nvim-dap-ui;
        obsidian-nvim = obsidian-nvim;
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

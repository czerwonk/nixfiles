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

in {
  nixpkgs.overlays = [
    (self: super: {
      hyprland = pkgs-unstable.hyprland;
      xdg-desktop-portal-hyprland = pkgs-unstable.xdg-desktop-portal-hyprland;
    })
    (self: super: {
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = pkgs-unstable.callPackage ./pkgs/ethr {};
      nix-alien = nix-alien-packages.nix-alien;
      provisionize = provisionize-packages.provisionize;
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      crowdsec = super.callPackage ./pkgs/crowdsec {};
      fractal = pkgs-unstable.fractal;
      go = pkgs-unstable.go;
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      kubevirt = pkgs-unstable.kubevirt;
      neovim = pkgs-unstable.neovim;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      omnisharp-roslyn = pkgs-unstable.omnisharp-roslyn;
      podman = pkgs-unstable.podman;
      sublime4 = pkgs-unstable.sublime4;
      termius = super.callPackage ./pkgs/termius {};
      unifi = pkgs-unstable.unifi8;
      vault = pkgs-unstable.vault;
      vimPlugins = super.vimPlugins // {
        harpoon2 = pkgs-unstable.vimPlugins.harpoon2;
        obsidian-nvim = super.callPackage ./pkgs/obsidian-nvim {};
        neotest = super.callPackage ./pkgs/neotest-nvim {};
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

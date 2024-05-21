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
  provisionize-packages = inputs.provisionize.packages.${system};

in {
  nixpkgs.overlays = [
    (self: super: {
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = super.callPackage ./pkgs/ethr {};
      provisionize = provisionize-packages.provisionize;
      termius = super.callPackage ./pkgs/termius {};
      vimPlugins = super.vimPlugins // {
        obsidian-nvim = super.callPackage ./pkgs/obsidian-nvim {};
      };
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      kubevirt = pkgs-unstable.kubevirt;
      sublime4 = pkgs-unstable.sublime4;
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

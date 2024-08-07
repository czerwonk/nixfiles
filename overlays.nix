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
      all-ways-egpu = super.callPackage ./pkgs/all-ways-egpu {};
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = super.callPackage ./pkgs/ethr {};
      provisionize = provisionize-packages.provisionize;
      termius = super.callPackage ./pkgs/termius {};
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      kubevirt = pkgs-unstable.kubevirt;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      oh-my-posh = pkgs-unstable.oh-my-posh;
      ollama = pkgs-unstable.ollama;
      sublime4 = pkgs-unstable.sublime4;
    })
    (self: super: {
      gnome = super.gnome // {
        gnome-keyring = super.gnome.gnome-keyring.overrideAttrs (oldAttrs: {
          configureFlags = oldAttrs.configureFlags or [ ] ++ [
            "--disable-ssh-agent"
          ];
        });
      };
      gnomeExtensions = super.gnomeExtensions // {
        pop-shell = super.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
          preFixup = oldAttrs.preFixup + ''
            echo '.pop-shell-search-element:select{ color: #DCD7BA !important; }' >> $out/share/gnome-shell/extensions/pop-shell@system76.com/light.css
          '';
        });
      };
    })
  ];
}

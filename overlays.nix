{ system, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };

  ansible-role-packages = inputs.ansible-role.packages.${system};
  dns-drain-packages = inputs.dns-drain.packages.${system};
  net-merge-packages = inputs.net-merge.packages.${system};

in {
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-core-combined"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
    "openssl-1.1.1w"
  ];

  nixpkgs.overlays = [
    (self: super: {
      all-ways-egpu = super.callPackage ./pkgs/all-ways-egpu {};
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = super.callPackage ./pkgs/ethr {};
      net-merge = net-merge-packages.net-merge;
      vimPlugins = super.vimPlugins // {
        gp-nvim = super.callPackage ./pkgs/gp-nvim {};
      };
    })
    (self: super: {
      unstable = pkgs-unstable;
      ansible = super.ansible.override { windowsSupport = true; };
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      oh-my-posh = pkgs-unstable.oh-my-posh;
      ollama = pkgs-unstable.ollama;
    })
    (self: super: {
      gnome-keyring = super.gnome-keyring.overrideAttrs (oldAttrs: {
        configureFlags = oldAttrs.configureFlags or [ ] ++ [
          "--disable-ssh-agent"
        ];
      });
      gnomeExtensions = super.gnomeExtensions // {
        pop-shell = super.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
          preFixup = oldAttrs.preFixup + ''
            echo '.pop-shell-search-element:select{ color: #DCD7BA !important; }' >> $out/share/gnome-shell/extensions/pop-shell@system76.com/light.css
          '';
        });
      };
      gvisor = super.gvisor.overrideAttrs (old: {
        version = "20241210.0";
        src = super.fetchFromGitHub {
          owner = "google";
          repo = "gvisor";
          rev = "aa8ecac76a04b495181d784d84bf9ecc4e1fb876";
          hash = "sha256-sX3Er0IOXv+HCxQB0lU9oBMTlQJgaf8OJnpkWkFLnRQ=";
        };
        vendorHash = "sha256-cWMOmCgN+nXZh0X7ZXoguIiFVSXIJAbuuBWxysbgn6U=";
      });
      termius = super.termius.overrideAttrs (old: {
        version = "9.6.1";
        src = super.fetchurl {
          url = "https://api.snapcraft.io/api/v1/snaps/download/WkTBXwoX81rBe3s3OTt3EiiLKBx2QhuS_204.snap";
          hash = "sha512-ok3B/h+d0Q7k5i+IjgGB+4S5g2kzrQT/b4dYz4k07OnyfjJRgJ4X4f7BFFrwKLd+IbIC5OIibrvivWnkSWU3Ew==";
        };
      });
    })
  ];
}

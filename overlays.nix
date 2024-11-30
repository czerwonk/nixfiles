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
  provisionize-packages = inputs.provisionize.packages.${system};

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
      provisionize = provisionize-packages.provisionize;
      termius = super.callPackage ./pkgs/termius {};
      vimPlugins = super.vimPlugins // {
        gp-nvim = super.callPackage ./pkgs/gp-nvim {};
      };
    })
    (self: super: {
      unstable = pkgs-unstable;
      ansible = super.ansible.override { windowsSupport = true; };
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
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
    })
  ];
}

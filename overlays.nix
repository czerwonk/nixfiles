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
  blink-cmp-packages = inputs.blink-cmp.packages.${system};
  ghostty-packages = inputs.ghostty.packages.${system};

in {
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  nixpkgs.overlays = [
    (self: super: {
      all-ways-egpu = super.callPackage ./pkgs/all-ways-egpu {};
      ansible-role = ansible-role-packages.ansible-role;
      dns-drain = dns-drain-packages.dns-drainctl;
      ethr = super.callPackage ./pkgs/ethr {};
      ghostty = ghostty-packages.default;
      net-merge = net-merge-packages.net-merge;
      vimPlugins = super.vimPlugins // {
        blink-cmp = blink-cmp-packages.blink-cmp;
        snacks-nvim = super.callPackage ./pkgs/snacks-nvim {};
      };
    })
    (self: super: {
      unstable = pkgs-unstable;
      ansible = super.ansible.override { windowsSupport = true; };
      claude-code = pkgs-unstable.claude-code;
      go = pkgs-unstable.go_1_24;
      gopls = pkgs-unstable.gopls;
      home-assistant = pkgs-unstable.home-assistant;
      k3s = pkgs-unstable.k3s;
      lua-language-server = pkgs-unstable.lua-language-server;
      oh-my-posh = pkgs-unstable.oh-my-posh;
      ollama = pkgs-unstable.ollama;
      termius = pkgs-unstable.termius;
      vimPlugins = super.vimPlugins // {
        avante-nvim = pkgs-unstable.vimPlugins.avante-nvim;
        codecompanion-nvim = pkgs-unstable.vimPlugins.codecompanion-nvim;
        copilot-lua = pkgs-unstable.vimPlugins.copilot-lua;
        dressing-nvim = pkgs-unstable.vimPlugins.dressing-nvim;
        plenary-nvim = pkgs-unstable.vimPlugins.plenary-nvim;
      };
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
    })
  ];
}

{
  system,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [
    (self: super: {
      unstable = pkgs-unstable;
    })
    (self: super: {
      ansible-role = inputs.ansible-role.packages.${system}.ansible-role;
      dns-drain = inputs.dns-drain.packages.${system}.dns-drainctl;
      hakanai-cli = inputs.hakanai.packages.${system}.hakanai-cli;
      net-reduce = inputs.net-reduce.packages.${system}.net-reduce;
      mcp-hub = inputs.mcp-hub.packages.${system}.default;
      load-env-bw = import ./pkgs/load-env-bw { inherit pkgs lib; };
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      claude-code = pkgs-unstable.claude-code;
      codex = pkgs-unstable.codex;
      home-assistant = pkgs-unstable.home-assistant;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      ollama-rocm = pkgs-unstable.ollama-rocm;
      termius = pkgs-unstable.termius;
      vimPlugins = pkgs-unstable.vimPlugins // {
        mcphub-nvim = inputs.mcphub-nvim.packages.${system}.default;
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
          preFixup =
            oldAttrs.preFixup
            + ''
              echo '.pop-shell-search-element:select{ color: #DCD7BA !important; }' >> $out/share/gnome-shell/extensions/pop-shell@system76.com/light.css
            '';

          patches = oldAttrs.patches or [ ] ++ [
            ./patches/pop-shell-gnome-48.patch
          ];
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

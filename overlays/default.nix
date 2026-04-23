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
      load-env-bw = import ../pkgs/load-env-bw { inherit pkgs lib; };
    })
    (self: super: {
      claude-code = pkgs-unstable.claude-code;
      dbeaver-bin = pkgs-unstable.dbeaver-bin;
      home-assistant = pkgs-unstable.home-assistant;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      ollama-rocm = pkgs-unstable.ollama-rocm;
      rocmPackages = pkgs-unstable.rocmPackages;
      termius = pkgs-unstable.termius;
      uutils-coreutils-noprefix = pkgs-unstable.uutils-coreutils-noprefix;
      vimPlugins = pkgs-unstable.vimPlugins;
      zed-editor = pkgs-unstable.zed-editor;
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
    })
    (import ./gnome-extensions.nix)
    (import ./gnome-keyring.nix)
  ];
}

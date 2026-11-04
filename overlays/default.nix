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
      hakanai-cli = inputs.hakanai.packages.${system}.hakanai-cli;
      net-reduce = inputs.net-reduce.packages.${system}.net-reduce;
      load-env-bw = import ../pkgs/load-env-bw { inherit pkgs lib; };
    })
    (self: super: {
      bitwarden-desktop = pkgs-unstable.bitwarden-desktop;
      claude-code = pkgs-unstable.claude-code;
      davinci-resolve-studio = pkgs-unstable.davinci-resolve-studio;
      home-assistant = pkgs-unstable.home-assistant;
      mattermost-desktop = pkgs-unstable.mattermost-desktop;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      ollama-rocm = pkgs-unstable.ollama-rocm;
      rocmPackages = pkgs-unstable.rocmPackages;
      termius = pkgs-unstable.termius;
      tuxbox = pkgs-unstable.tuxbox;
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

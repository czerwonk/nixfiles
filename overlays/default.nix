{
  system,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  nixpkgs-unstable-patched = pkgs.applyPatches {
    name = "nixpkgs-unstable-patched";
    src = inputs.nixpkgs-unstable;
    patches = [ ../patches/davinci-resolve-v21.patch ];
  };

  pkgs-unstable = import nixpkgs-unstable-patched {
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
      davinci-resolve-studio = pkgs-unstable.davinci-resolve-studio;
      home-assistant = pkgs-unstable.home-assistant;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      ollama-rocm = pkgs-unstable.ollama-rocm;
      rocmPackages = pkgs-unstable.rocmPackages;
      termius = pkgs-unstable.termius;
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

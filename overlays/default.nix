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
      load-env-bw = import ../pkgs/load-env-bw { inherit pkgs lib; };
      opencode = inputs.nixpkgs-opencode.legacyPackages.${system}.opencode;
    })
    (self: super: {
      ansible = super.ansible.override { windowsSupport = true; };
      claude-code = pkgs-unstable.claude-code;
      codex = pkgs-unstable.codex;
      gemini-cli = pkgs-unstable.gemini-cli;
      home-assistant = pkgs-unstable.home-assistant;
      neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
      ollama-rocm = pkgs-unstable.ollama-rocm;
      termius = pkgs-unstable.termius;
      vimPlugins = pkgs-unstable.vimPlugins // {
        mcphub-nvim = inputs.mcphub-nvim.packages.${system}.default;
      };
    })
    (import ./gnome-extensions.nix)
    (import ./gnome-keyring.nix)
    (import ./gvisor.nix)
    (import ./ollama-rocm-apu.nix)
  ];
}

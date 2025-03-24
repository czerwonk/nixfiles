{ pkgs, lib, config, username, ... }:

{
  imports = [
    ../../programs/ghostty
    ./librewolf.nix
    ./neovide.nix
  ];

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package} --tmux";
    bww = "BITWARDENCLI_APPDATA_DIR='/home/${username}/.config/Bitwarden CLI Work' ${lib.getExe pkgs.bitwarden-cli} $@";
  };

  programs.tmux.mouse = true;

  programs.neovim.withLLM = true;

  services.gpg-agent.enable = true;

  home = {
    packages = with pkgs; [
      bitwarden-cli
    ];
    shellAliases = {
      nvim = "${lib.getExe config.programs.neovim.sandboxPackage}";
    };
  };

  my.scripts.neovimExe = "${lib.getExe config.programs.neovim.sandboxPackage}";

  programs.zsh = {
    shellAliases = {
      docker = "${lib.getExe pkgs.podman}";
    };
  };
}

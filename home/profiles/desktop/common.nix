{ pkgs, lib, config, ... }:

{
  imports = [
    ../../programs/kitty
  ];

  home.packages = with pkgs; [
    wl-clipboard
  ];

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package}";
  };

  programs.tmux.mouse = true;

  services.gpg-agent.enable = true;
}

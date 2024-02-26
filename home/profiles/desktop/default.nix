{ pkgs, config, ... }:

{
  imports = [
    ../../programs/kitty
  ];

  programs.zsh.shellAliases = {
    ycode = "${pkgs.yubikey-manager}/bin/ykman oath accounts code | ${config.programs.fzf.package}/bin/fzf";
  };
  
  programs.tmux.mouse = true;
  services.gpg-agent.enable = true;
}

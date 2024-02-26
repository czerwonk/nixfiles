{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/suits/linux-utils
    ../../home/suits/devops/lsp.nix
  ] ++ extraHomeModules;

  services.gpg-agent.enable = true;

  programs.zsh.theme.enable = false;
  programs.tmux.theme.enable = false;
}

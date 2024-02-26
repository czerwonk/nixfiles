{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/suits/linux-utils
  ] ++ extraHomeModules;

  services.gpg-agent.enable = true;

  programs.zsh.theme.enable = false;
  programs.tmux.theme.enable = false;
}

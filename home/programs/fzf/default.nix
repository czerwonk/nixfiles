{ lib, ... }:

{
  programs.fzf = {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    tmux = {
      enableShellIntegration = true;
    };
  };
}

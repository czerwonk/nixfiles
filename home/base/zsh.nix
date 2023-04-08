{ config, lib, pkgs, workspace, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";
    completionInit = ""; # is called by GRML
    initExtraFirst = ''
      export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      export ZSH_THEME="powerlevel10k/powerlevel10k"
      source ~/.p10k.zsh
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    '';
    initExtra = ''
      source ~/.zshrc.local
      if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
    '';
    envExtra = ''
      export WORKSPACE=${workspace}
    '';
    shellAliases = {
      l = "exa -l --icons --group-directories-first --time-style long-iso";
      ls = "ls --color=auto";
      ll = "exa -l --icons --group-directories-first --time-style long-iso";
      la = "exa -la --icons --group-directories-first --time-style long-iso";
      cat  = "bat -pp";
      fzfp = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      switch-env = "bash ~/.switch-env.sh";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
    };
    history = {
      expireDuplicatesFirst = true;
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
  home.file.".zshrc.local".source = ./config/zsh/zshrc.local;
  home.file.".p10k.zsh".source = ./config/zsh/p10k.zsh;
}

{ pkgs, ... }:

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
    shellAliases = {
      l = "exa -l --icons --group-directories-first --time-style long-iso";
      ls = "ls --color=auto";
      ll = "exa -l --icons --group-directories-first --time-style long-iso";
      la = "exa -la --icons --group-directories-first --time-style long-iso";
      cat  = "bat -pp";
      fzfp = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      ycode = "ykman oath accounts code | fzf";
      g = "git";
      gs = "git status";
      ga = "git add";
      gd = "git diff HEAD";
      gp = "git push";
      commit = "git commit -a -m";
      k = "kubectl";
      kexec = "kubectl exec -it";
      klog = "kubectl logs";
    };
    envExtra = ''
      export WORKSPACE=
    '';
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
  home.file.".zshrc.local".source = ./zshrc.local;
  home.file.".p10k.zsh".source = ./p10k.zsh;
}

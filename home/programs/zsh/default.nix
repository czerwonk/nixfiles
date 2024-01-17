{ pkgs, lib, config, ... }:

{
  programs.zsh = {
    enable = lib.mkDefault true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
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
      l = "${pkgs.eza}/bin/eza -l --icons --group-directories-first --time-style long-iso";
      ls = "ls --color=auto";
      ll = "${pkgs.eza}/bin/eza -l --icons --group-directories-first --time-style long-iso";
      la = "${pkgs.eza}/bin/eza -la --icons --group-directories-first --time-style long-iso";
      cat  = "${pkgs.bat}/bin/bat -pp";
      fzfp = "${config.programs.fzf.package}/bin/fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      curl = "${pkgs.curlie}/bin/curlie";
      ycode = "ykman oath accounts code | fzf";
      g = "${config.programs.git.package}/bin/git";
      gs = "${config.programs.git.package}/bin/git status";
      ga = "${config.programs.git.package}/bin/git add";
      gd = "${config.programs.git.package}/bin/git diff HEAD";
      gp = "${config.programs.git.package}/bin/git push";
      commit = "${config.programs.git.package}/bin/git commit -a -m";
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

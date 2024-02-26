{ pkgs, lib, config, ... }:

{
  imports = [
    ./theme.nix
  ];

  programs.zsh = {
    enable = lib.mkDefault true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    completionInit = ""; # is called by GRML
    initExtraFirst = ''
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    '';
    initExtra = ''
      source ~/.zshrc.local
      if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
    '';
    shellAliases = {
      l = "${pkgs.eza}/bin/eza -l --group --icons --group-directories-first --time-style long-iso";
      ls = "${pkgs.eza}/bin/eza --group";
      ll = "${pkgs.eza}/bin/eza -l --group --icons --group-directories-first --time-style long-iso";
      la = "${pkgs.eza}/bin/eza -la --group --icons --group-directories-first --time-style long-iso";
      tree = "${pkgs.eza}/bin/eza --tree";
      cat  = "${pkgs.bat}/bin/bat -pp";
      fzfp = "${config.programs.fzf.package}/bin/fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      curl = "${pkgs.curlie}/bin/curlie";
    };
    history = {
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };
  };

  home.file.".zshrc.local".source = ./zshrc.local;
}

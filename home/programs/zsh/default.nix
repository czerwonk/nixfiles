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
      l = "${lib.getExe pkgs.eza} -lH --group --icons --group-directories-first --time-style long-iso";
      ls = "${lib.getExe pkgs.eza} --group -H";
      ll = "${lib.getExe pkgs.eza} -lH --group --icons --group-directories-first --time-style long-iso";
      la = "${lib.getExe pkgs.eza} -laH --group --icons --group-directories-first --time-style long-iso";
      tree = "${lib.getExe pkgs.eza} --tree";
      cat  = "${lib.getExe pkgs.bat} -pp";
      fzfp = "${lib.getExe config.programs.fzf.package} --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
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

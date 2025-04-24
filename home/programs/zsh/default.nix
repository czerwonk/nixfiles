{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.zsh = {
    enable = lib.mkDefault true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    initContent = ''
      bindkey "^[[1;3D" backward-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[^[[D"  backward-word
      bindkey "^[^[[C"  forward-word
      bindkey "^[[1;5D"  backward-word
      bindkey "^[[1;5C"  forward-word
      bindkey "^[^?"    backward-kill-word

      autoload zmv

      # history
      ${builtins.readFile ./history.zsh}

      # completion
      ${builtins.readFile ./completion.zsh}

      # highlighting
      ${builtins.readFile ./highlight.zsh}

      ${builtins.readFile ./functions.zsh}

      if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

      source ~/.profile
    '';
    shellAliases = {
      cat = "${lib.getExe pkgs.bat} -pp";
      curl = "${lib.getExe pkgs.curlie}";
      egrep = "egrep --color=auto";
      fzfp = "${lib.getExe config.programs.fzf.package} --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      grep = "grep --color=auto";
      l = "${lib.getExe pkgs.eza} -lH --group --icons --group-directories-first --time-style long-iso";
      la = "${lib.getExe pkgs.eza} -laH --group --icons --group-directories-first --time-style long-iso";
      ll = "${lib.getExe pkgs.eza} -lH --group --icons --group-directories-first --time-style long-iso";
      ls = "${lib.getExe pkgs.eza} --group -H";
      tree = "${lib.getExe pkgs.eza} --tree";
      ttfb = "${lib.getExe pkgs.curl} -o /dev/null -s -w \"Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \\n\" $@";
    };
    history = {
      size = 50000;
      save = 50000;
      share = true;
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };
  };
}

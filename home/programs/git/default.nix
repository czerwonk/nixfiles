{ lib, config, ... }:

{
  programs.git = {
    enable = lib.mkDefault true;
    aliases = {
      graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative";
      co = "checkout";
      br = "branch";
      c = "commit";
      st = "status";
      rb = "rebase";
      ls = "ls-files";
      pu = "push";
      p = "pull";
      f = "fetch";
      ignores = "ls-files -o -i --exclude-standard";
    };
    signing = {
      signByDefault = true;
    };
    ignores = [
      "coverage.out"
    ];
    extraConfig = {
      extensions.worktreeConfig = true;
      core = {
        editor = "nvim";
        commitGraph = true;
      };
      color.ui = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      merge.tool = "nvim";
      mergetool = {
        prompt = false;
        nvim.cmd = "nvim -f -c \"Gdiffsplit!\" \"$MERGED\"";
      };
      rerere.enabled = true;
    };
  };

  programs.zsh.shellAliases = {
    g = "${config.programs.git.package}/bin/git";
    gs = "${config.programs.git.package}/bin/git status";
    ga = "${config.programs.git.package}/bin/git add";
    gd = "${config.programs.git.package}/bin/git diff HEAD";
    gp = "${config.programs.git.package}/bin/git push";
    commit = "${config.programs.git.package}/bin/git commit -a -m";
  };
}

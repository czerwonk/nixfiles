{ config, lib, pkgs, signingkey, ... }:

{
  programs.git = {
    enable = true;
    userName = "Daniel Czerwonk";
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
    extraConfig = {
      extensions.worktreeConfig = true;
      github.user = "czerwonk";
      core = {
        editor = "vim";
        commitGraph = true;
      };
      color.ui = true;
      pull.rebase = true;
      user.signingKey = "${signingkey}";
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}

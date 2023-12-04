{ lib, ... }:

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
      commit.gpgsign = true;
      tag.gpgsign = true;
      merge.tool = "nvim";
      mergetool.prompt = false;
      mergetool.nvim.cmd = "nvim -f -c \"Gdiffsplit!\" \"$MERGED\"";
    };
  };
}

{ lib, config, ... }:

{
  programs.git = {
    enable = lib.mkDefault true;
    aliases = {
      br = "branch";
      c = "commit";
      co = "checkout";
      f = "fetch";
      ignores = "ls-files -o -i --exclude-standard";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ls = "ls-files";
      p = "pull";
      pu = "push";
      rb = "rebase";
      st = "status";
      sw = "switch";
    };
    signing = {
      signByDefault = true;
    };
    ignores = [
      "coverage.out"
    ];
    extraConfig = {
      extensions.worktreeConfig = true;

      branch = {
        sort = "-committerdate";
      };

      core = {
        editor = "nvim";
        commitGraph = true;
      };

      color.ui = true;

      gpg.format = "ssh";

      init = {
        defaultBranch = "main";
      };

      pull.rebase = true;

      push = {
        default = "matching";
        autoSetupRemote = true;
      };

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

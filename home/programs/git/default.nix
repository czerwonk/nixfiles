{ lib, config, ... }:

{
  programs.git = {
    enable = lib.mkDefault true;
    aliases = {
      br = "branch";
      c = "commit -a -m";
      ca = "!git add -A && git commit -m";
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

      gpg = {
        format = "ssh";
        ssh = {
          defaultKeyCommand = "sh -c 'echo key::$(ssh-add -L | head -n1)'";
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      commit = {
        gpgSign = true;
      };
      tag = {
        gpgSign = true;
      };

      init = {
        defaultBranch = "main";
      };

      pull.rebase = true;

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      diff = {
        tool = "nvimdiff";
      };


      difftool = {
        prompt = false;
        nvimdiff = {
          cmd = "nvim -d -R $LOCAL $REMOTE";
        };
      };

      merge = {
        tool = "nvimdiff";
        conflictStyle = "diff3";
      };

      mergetool = {
        prompt = false;
        keepBackup = false;
        keepTemporaries = false;
        nvimdiff = {
          cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          trustExitCode = false;
        };
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

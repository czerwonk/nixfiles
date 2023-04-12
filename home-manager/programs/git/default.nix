{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Daniel Czerwonk";
    userEmail = "daniel@routing.rocks";
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
      user.signingKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC5NEvD6tPxgg2MrQpJz6bl0gac3iJEJ6FKT2yebj5aYP30lTogZiyCTfTls30SkeNKfUkEjlIrF6ShfVcry/VTsZyARXYCv1NJcvdHcpvuufvuhlfzhmD0vnp/VVZbhuLyILzBOdGjJ7eBT886m3GkOG1EYw7HA+XZFLbrEdQMcASSBQaULhhWSZI0s1W8hiG7Jg8cMdgjJkhQALTKkfOmV/FzZ4ZS6OLspBrPxUxIwKUyYhGJ54KCvhQ8eV3av7x87cwMUc/gBhpI2upq86U+wVSBPkUt1GNHrQLVpAQ5cBut4BhKMU9w+B71TEIcPSSNwy3Efv5x3gSkGEDzU2AVc0KQyBTs38IWGB1UXEGTtbVI9JzAoDNJjjGXqOClgLc7Quyv58CabzhlELtPUtIqoRJGggiwhYJ7oiPbNkBDe+AfIWIbCwIunShmxQA+5oeAuZGOgLCPoryyjzyvKHx4W/jESvbji3YACZ2362UcoJOx6yNlE6Bhvo8+y3fUvjQjqgOXR2siMWVUuhXfzJsFYMBtA2R5NgqioWqveGmgBbeW+mG/X91f09ZEm5Edn6VYK4FAGJFizVdadp15KlgUPFUuS+6q/i5rXMjeQCnC6anXjPHJQpSYgmoZjjgI9WUGkGoqwSxmCfgEBg5rI9JW38TqEt0Z4gjZ6ViRee2Sw==";
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}

{ pkgs, ... }:

{
  home = {
    shellAliases = {
      switch-env = "bash ~/.scripts/switch-env.sh";
      git-worktree-it = "bash ~/.scripts/git-worktree-it.sh";
    };
    file.".scripts/switch-env.sh".text = ''
      #!/bin/bash
      set -e

      home-manager switch --flake "$HOME/.nixfiles#$1"
    '';
    file.".scripts/git-worktree-it.sh".text = builtins.readFile ./git-worktree-it.sh; 
  };
}

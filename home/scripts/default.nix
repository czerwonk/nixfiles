{
  home = {
    shellAliases = {
      switch-env = "bash ~/.scripts/switch-env.sh";
      git-worktree-it = "bash ~/.scripts/git-worktree-it.sh";
      git-worktree-clone = "bash ~/.scripts/git-worktree-clone.sh";
      vim = "bash ~/.scripts/nvim-tmux.sh";
      ansible-role = "bash ~/.scripts/ansible-role.sh";
    };
    file.".scripts" = {
      source = ./files;
      recursive = true;
    };
  };
}

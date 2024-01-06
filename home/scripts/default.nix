{ pkgs, lib, ... }:

let
  git-worktree-it = pkgs.writeScriptBin "git-worktree-it" ("PATH=$PATH:${lib.makeBinPath [ pkgs.perl ]}\n" + (builtins.readFile ./git-worktree-it.sh));
  git-worktree-clone = pkgs.writeScriptBin "git-worktree-clone" (builtins.readFile ./git-worktree-clone.sh);
  nvim-tmux = pkgs.writeShellScriptBin "nvim-tmux" (builtins.readFile ./nvim-tmux.sh);

in {
  home = {
    packages = [
      git-worktree-it
      git-worktree-clone
      nvim-tmux
    ];
    shellAliases = {
      vim = "${nvim-tmux}/bin/nvim-tmux";
    };
  };
}

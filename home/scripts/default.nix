{ pkgs, lib, config, username, ... }:

with lib;

let
  cfg = config.my.scripts;
  git-worktree-it = pkgs.writeScriptBin "git-worktree-it" ("PATH=$PATH:${lib.makeBinPath [ pkgs.perl ]}\n" + (builtins.readFile ./git-worktree-it.sh));
  git-worktree-clone = pkgs.writeScriptBin "git-worktree-clone" (builtins.readFile ./git-worktree-clone.sh);
  nvim-tmux = pkgs.writeShellScriptBin "nvim-tmux" ''
    if [[ -z $TMUX ]]; then
      ${cfg.neovimExe} $@
      exit 0
    fi

    tmux rename-window nvim
    tmux split-window
    tmux resize-pane -t 2 -y 10
    tmux select-pane -t 1
    tmux resize-pane -Z
    ${cfg.neovimExe} $@
    tmux kill-pane -a -t 2
  '';

in {
  options = {
    my.scripts.neovimExe = mkOption {
      type = types.str;
      default = "/etc/profiles/per-user/${username}/bin/nvim";
      description = "The neovim executable to use";
    };
  };

  config = {
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
  };
}

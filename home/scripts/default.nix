{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.scripts;
  git-pull-all = pkgs.writeShellScriptBin "git-pull-all" (builtins.readFile ./git-pull-all.sh);
  nvim-tmux = pkgs.writeShellScriptBin "nvim-tmux" ''
    if [[ -z $TMUX ]]; then
      ${cfg.neovimExe} "$@"
      exit 0
    fi

    tmux rename-window nvim
    tmux split-window
    tmux resize-pane -t 2 -y 10
    tmux select-pane -t 1
    tmux resize-pane -Z
    ${cfg.neovimExe} "$@"
    tmux kill-pane -a -t 2
  '';

in
{
  options = {
    my.scripts.neovimExe = mkOption {
      type = types.str;
      default = "${lib.getExe config.programs.neovim.finalPackage}";
      description = "The neovim executable to use";
    };
  };

  config = {
    home = {
      packages = [
        git-pull-all
        nvim-tmux
      ];
      shellAliases = {
        vim = "${nvim-tmux}/bin/nvim-tmux";
      };
    };
  };
}

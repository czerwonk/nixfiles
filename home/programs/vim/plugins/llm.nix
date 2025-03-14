{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.programs.neovim;

in {
  options = {
    programs.neovim.withLLM = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.withLLM {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        {
          plugin = codecompanion-nvim;
          type = "lua";
          config = builtins.readFile ./lua/codecompanion.lua;
        }
        {
          plugin = plenary-nvim;
        }
      ];
    };
  };
}

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
          plugin = avante-nvim;
          type = "lua";
          config = builtins.readFile ./lua/avante.lua;
        }
        {
          plugin = plenary-nvim;
        }
        {
          plugin = dressing-nvim;
        }
      ];
    };
  };
}

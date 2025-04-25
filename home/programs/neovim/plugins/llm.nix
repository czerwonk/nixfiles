{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  options = {
    programs.neovim.withLLM = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.programs.neovim.withLLM {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        {
          plugin = avante-nvim;
          type = "lua";
          config = builtins.readFile ./lua/avante.lua;
        }
        {
          plugin = dressing-nvim;
        }
        {
          plugin = copilot-vim;
          type = "lua";
          config = builtins.readFile ./lua/copilot.lua;
        }
      ];
    };
  };
}

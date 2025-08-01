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
          plugin = dressing-nvim;
        }
        {
          plugin = avante-nvim;
          type = "lua";
          config = builtins.readFile ./lua/avante.lua;
        }
        {
          plugin = copilot-lua;
          type = "lua";
          config = builtins.readFile ./lua/copilot.lua;
        }
      ];
      extraPackages = with pkgs; [
        nodejs
      ];
    };
  };
}

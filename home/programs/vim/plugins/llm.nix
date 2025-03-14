{ pkgs, ... }:

{
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
}

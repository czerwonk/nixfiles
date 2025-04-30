{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nui-nvim;
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = "require('colorizer').setup()";
      }
      {
        # theme
        plugin = kanagawa-nvim;
        type = "lua";
        config = builtins.readFile ./lua/theme.lua;
      }
    ];
  };
}

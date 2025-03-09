{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nui-nvim;
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = builtins.readFile ./lua/noice.lua;
      }
      {
        plugin = rainbow-delimiters-nvim;
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = "require('colorizer').setup()";
      }

      # theme
      {
        plugin = kanagawa-nvim;
        type = "lua";
        config = builtins.readFile ./lua/theme.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./lua/lualine.lua;
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = builtins.readFile ./lua/bufferline.lua;
      }
    ];
  };
}

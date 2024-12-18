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
        plugin = dressing-nvim;
        type = "lua";
        config = "require('dressing').setup()";
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./lua/neo-tree.lua;
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
      {
        plugin = barbecue-nvim;
        type = "lua";
        config = builtins.readFile ./lua/barbecue.lua;
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = "require('nvim-web-devicons').get_icons()";
      }
    ];
  };
}

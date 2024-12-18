{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./lua/telescope.lua;
      }
      {
        plugin = telescope-file-browser-nvim;
        type = "lua";
        config = "require('telescope').load_extension('file_browser')";
      }
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = "require('telescope').load_extension('fzf')";
      }
      {
        plugin = telescope-undo-nvim;
      }
    ];
  };
}

{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = luasnip;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      {
        plugin = cmp-nvim-lsp;
      }
      {
        plugin = cmp-path;
      }
      {
        plugin = cmp-calc;
      }
      {
        plugin = cmp-buffer;
      }
    ];
  };
}

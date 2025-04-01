{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      {
        plugin = blink-compat;
      }
    ];
  };
}

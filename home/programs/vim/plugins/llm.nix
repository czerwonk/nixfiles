{ pkgs, ... }:
{
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
}

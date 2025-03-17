{ pkgs, ... }:

{
  imports = [
    ./ui.nix
    ./treesitter.nix
    ./cmp.nix
    ./dev.nix
    ./llm.nix
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = mini-nvim;
        type = "lua";
        config = builtins.readFile ./lua/mini.lua;
      }
      {
        plugin = snacks-nvim;
        type = "lua";
        config = builtins.readFile ./lua/snacks.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./lua/which-key.lua;
      }
      {
        plugin = vim-tmux-navigator;
        type = "lua";
        config = builtins.readFile ./lua/vim-tmux-navigator.lua;
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./lua/neo-tree.lua;
      }
      {
        plugin = SchemaStore-nvim;
      }
      {
        plugin = render-markdown-nvim;
        type = "lua";
        config = builtins.readFile ./lua/render-markdown.lua;
      }
    ];
  };
}

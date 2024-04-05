{ pkgs, ... }:

{
  imports = [
    ./ui.nix
    ./telescope.nix
    ./treesitter.nix
    ./cmp.nix
    ./dev.nix
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = mini-nvim;
        type = "lua";
        config = builtins.readFile ./lua/mini.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./lua/which-key.lua;
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }
      {
        plugin = vim-tmux-navigator;
        type = "lua";
        config = builtins.readFile ./lua/vim-tmux-navigator.lua;
      }
      {
        plugin = harpoon2;
        type = "lua";
        config = builtins.readFile ./lua/harpoon.lua;
      }
      {
        plugin = nvim-neoclip-lua;
        type = "lua";
        config = builtins.readFile ./lua/neoclip.lua;
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./lua/toggleterm.lua;
      }
      {
        plugin = vim-fugitive;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gitsigns.lua;
      }
      {
        plugin = git-worktree-nvim;
        type = "lua";
        config = builtins.readFile ./lua/git-worktree.lua;
      }
      {
        plugin = SchemaStore-nvim;
      }
      {
        plugin = vim-helm;
      }
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = "require('todo-comments').setup()";
      }
      {
        plugin = obsidian-nvim;
        type = "lua";
        config = builtins.readFile ./lua/obsidian.lua;
      }
    ];
  };
}

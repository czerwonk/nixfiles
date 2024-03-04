{ pkgs, ... }:

let
  obsidian = pkgs.vimUtils.buildVimPlugin {
    pname = "obsidian.nvim";
    version = "v2.5";
    src = pkgs.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "88bf9150d9639a2cae3319e76abd7ab6b30d27f0";
      hash = "sha256-irPk9iprbI4ijNUjMxXjw+DljudZ8aB3f/FJxXhFSoA=";
    };
    meta.homepage = "https://github.com/epwalsh/obsidian.nvim/";
  };

in {
  imports = [
    ./ui.nix
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
        plugin = telescope-project-nvim;
      }
      {
        plugin = telescope-undo-nvim;
      }
      {
        plugin = harpoon;
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
        plugin = obsidian;
        type = "lua";
        config = builtins.readFile ./lua/obsidian.lua;
      }
    ];
  };
}

{ pkgs-unstable, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    plugins = with pkgs-unstable.vimPlugins; [
      {
        plugin = nui-nvim;
      }
      {
        plugin = mini-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/mini.lua;
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/noice.lua;
      }
      {
        plugin = nvim-notify;
        type = "lua";
        config = builtins.readFile ./plugins/notify.lua;
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = "require('colorizer').setup()";
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/neo-tree.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/which-key.lua;
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }
      {
        plugin = undotree;
        type = "lua";
        config = builtins.readFile ./plugins/undotree.lua;
      }
      {
        plugin = vim-tmux-navigator;
        type = "lua";
        config = builtins.readFile ./plugins/vim-tmux-navigator.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/telescope.lua;
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
        plugin = harpoon;
        type = "lua";
        config = builtins.readFile ./plugins/harpoon.lua;
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/toggleterm.lua;
      }
      {
        plugin = vim-fugitive;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns.lua;
      }
      {
        plugin = git-worktree-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/git-worktree.lua;
      }
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./plugins/luasnip.lua;
      }
      {
        plugin = friendly-snippets;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/cmp.lua;
      }
      {
        plugin = cmp_luasnip;
      }
      {
        plugin = cmp-nvim-lsp;
      }
      {
        plugin = cmp-path;
      }
      {
        plugin = cmp-buffer;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lsp.lua;
      }
      {
        plugin = lsp-inlayhints-nvim;
      }
      {
        plugin = SchemaStore-nvim;
      }
      {
        plugin = nvim-navic;
      }
      {
        plugin = nvim-navbuddy;
      }
      {
        plugin = refactoring-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/refactoring.lua; 
      }
      {
        plugin = (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-bash
            tree-sitter-cmake
            tree-sitter-c
            tree-sitter-c-sharp
            tree-sitter-css
            tree-sitter-dockerfile
            tree-sitter-go
            tree-sitter-gomod
            tree-sitter-hcl
            tree-sitter-html
            tree-sitter-java
            tree-sitter-json
            tree-sitter-jsonnet
            tree-sitter-latex
            tree-sitter-lua
            tree-sitter-make
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-nix
            tree-sitter-perl
            tree-sitter-php
            tree-sitter-proto
            tree-sitter-python
            tree-sitter-regex
            tree-sitter-ruby
            tree-sitter-rust
            tree-sitter-sql
            tree-sitter-terraform
            tree-sitter-typescript
            tree-sitter-toml
            tree-sitter-vim
            tree-sitter-yaml
            tree-sitter-zig
          ]
        ));
        type = "lua";
        config = builtins.readFile ./plugins/tree-sitter.lua;
      }
      {
        plugin = nvim-treesitter-textobjects;
      }
      {
        plugin = nvim-treesitter-refactor;
      }
      {
        plugin = nvim-ts-rainbow2;
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/indent-blankline.lua;
      }
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = "require('todo-comments').setup()";
      }
      {
        plugin = nvim-dap;
      }
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config = "require('nvim-dap-virtual-text').setup()";
      }
      {
        plugin = nvim-dap-ui;
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/trouble.lua;
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = builtins.readFile ./plugins/copilot.lua;
      }
      {
        plugin = copilot-cmp;
      }

      # theme
      {
        plugin = kanagawa-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/theme.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/lualine.lua;
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/bufferline.lua;
      }
      { 
        plugin = barbecue-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/barbecue.lua;
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = "require('nvim-web-devicons').get_icons()";
      }
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}

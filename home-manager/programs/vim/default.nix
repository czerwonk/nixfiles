{ config, lib, pkgs, ... }:

let
  lspsaga_nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lspsaga.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "fb476086012e18e0001c3dcc5b18fd34a847e5fe";
      sha256 = "sha256-396xNjMoMvfpHGqu27JuTTafKepWGkHG29TjV8taHZY=";
    };
  }; 
  persistence_nvim = pkgs.vimUtils.buildVimPlugin {
    name = "persistence.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "persistence.nvim";
      rev = "c814fae5c37aa0aba9cd9da05df6e52b88d612c3";
      sha256 = "sha256-IjFJcXyfax72AsypO4HVRmG/kIBDB74PdSVcIrxRLqY=";
    };
  };

in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      persistence_nvim
      nvim-tree-lua
      which-key-nvim
      comment-nvim
      undotree
      telescope-nvim
      telescope-fzf-native-nvim
      harpoon
      toggleterm-nvim
      vim-fugitive
      gitsigns-nvim
      git-worktree-nvim
      vim-vsnip
      nvim-cmp
      cmp-nvim-lsp
      cmp-vsnip
      cmp-path
      cmp-buffer
      nvim-lspconfig
      nvim-lsputils
      lspsaga_nvim
      lsp_signature-nvim
      nvim-navic
      refactoring-nvim
      nvim-autopairs
      (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-bash
            tree-sitter-cmake
            tree-sitter-c
            tree-sitter-c-sharp
            tree-sitter-css
            tree-sitter-dockerfile
            tree-sitter-go
            tree-sitter-gomod
            tree-sitter-html
            tree-sitter-java
            tree-sitter-json
            tree-sitter-jsonnet
            tree-sitter-latex
            tree-sitter-lua
            tree-sitter-make
            tree-sitter-markdown
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
            tree-sitter-yaml
          ]
        ))
      nvim-treesitter-refactor
      nvim-ts-rainbow2
      indent-blankline-nvim
      todo-comments-nvim
      nvim-dap
      nvim-dap-ui
      trouble-nvim
      go-nvim
      rust-tools-nvim

      # theme
      lualine-nvim
      barbecue-nvim
      vim-code-dark
      nvim-web-devicons
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}

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
  vscode_nvim = pkgs.vimUtils.buildVimPlugin {
    name = "vscode.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Mofiqul";
      repo = "vscode.nvim";
      rev = "d89fa59a78eda50158d94bde059953bda2f56142";
      sha256 = "sha256-CI30wv2XfucOGgmplTnQGkml4ykyaGGVjRdYAa1kWTk=";
    };
  };
  guihua_lua = pkgs.vimUtils.buildVimPlugin {
    name = "guihua.lua";
    buildPhase = "rm Makefile";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "d331b1526a87edbe13679298c3547d49f8a14ffc";
      sha256 = "sha256-8VbynF1b9HXyJFAoW1/ReNX57tzUSiqqtktwqFjavp8=";
    };
  };
  copilot_lua = pkgs.vimUtils.buildVimPlugin {
    name = "copilot.lua";
    src = pkgs.fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "decc8d43bcd73a288fa689690c20faf0485da217";
      sha256 = "sha256-3u8qcfdFOk29XptTfm3UrPPM/lyDlicqj0jWQaySmqM=";
    };
  };
  copilot_cmp = pkgs.vimUtils.buildVimPlugin {
    name = "copilot-cmp";
    src = pkgs.fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot-cmp";
      rev = "99467081478aabe4f1183a19a8ba585e511adc20";
      sha256 = "sha256-5tKT2F+E7/keYr7HwNDFtEvw3IW47AyXu5ePwk4u4mM=";
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
      nui-nvim
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
        plugin = persistence_nvim;
        type = "lua";
        config = builtins.readFile ./plugins/persistence.lua;
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-tree.lua;
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
        plugin = nvim-surround;
        type = "lua";
        config = "require('nvim-surround').setup()";
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
      telescope-fzf-native-nvim
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
      vim-fugitive
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
      friendly-snippets
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/cmp.lua;
      }
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lsp.lua;
      }
      nvim-lsputils
      lspsaga_nvim
      nvim-navic
      {
        plugin = refactoring-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/refactoring.lua; 
      }
      nvim-autopairs
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
          ]
        ));
        type = "lua";
        config = builtins.readFile ./plugins/tree-sitter.lua;
      }
      nvim-treesitter-refactor
      nvim-ts-rainbow2
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
      nvim-dap
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config = "require('nvim-dap-virtual-text').setup()";
      }
      nvim-dap-ui
      {
        plugin = trouble-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/trouble.lua;
      }
      go-nvim
      guihua_lua
      rust-tools-nvim
      {
        plugin = copilot_lua;
        type = "lua";
        config = builtins.readFile ./plugins/copilot.lua;
      }
      copilot_cmp

      # theme
      {
        plugin = vscode_nvim;
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

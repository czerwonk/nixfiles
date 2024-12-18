{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
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
            tree-sitter-http
            tree-sitter-java
            tree-sitter-json
            tree-sitter-jsonnet
            tree-sitter-latex
            tree-sitter-lua
            tree-sitter-make
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-norg
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
        config = builtins.readFile ./lua/tree-sitter.lua;
      }
      {
        plugin = nvim-treesitter-textobjects;
      }
      {
        plugin = nvim-treesitter-refactor;
      }
      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = "require('nvim-ts-autotag').setup()";
      }
    ];
  };
}

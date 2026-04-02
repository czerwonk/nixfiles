{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = (
          nvim-treesitter.withPlugins (
            p: with p; [
              bash
              cmake
              c
              c_sharp
              css
              dockerfile
              go
              gomod
              hcl
              html
              http
              java
              json
              jsonnet
              latex
              lua
              make
              markdown
              markdown_inline
              nix
              perl
              php
              proto
              python
              regex
              ruby
              rust
              sql
              terraform
              typescript
              toml
              vim
              vimdoc # replaces "vim" docs parser
              yaml
              zig
            ]
          )
        );
        type = "lua";
        config = builtins.readFile ./lua/treesitter.lua;
      }
      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = "require('nvim-ts-autotag').setup()";
      }
      {
        plugin = rainbow-delimiters-nvim;
      }
    ];
  };
}

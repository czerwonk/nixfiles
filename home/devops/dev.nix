{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gnumake
      go_1_20
      goreleaser
      gopls
      sqlite
      protobuf
      jsonnet
      rustc
      cargo
      rustfmt
      rust-analyzer
      ruby
      solargraph
      pyright
      python3
      typescript
      deno
      nodePackages.typescript-language-server
      sumneko-lua-language-server
      rnix-lsp
      clippy
      reuse
    ];
  };
}

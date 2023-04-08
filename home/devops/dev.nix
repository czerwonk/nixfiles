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
      sumneko-lua-language-server
      rnix-lsp
      clippy
      reuse
    ] ++ (with pkgs.nodePackages; [
        typescript-language-server
        bash-language-server
    ]);
  };
}

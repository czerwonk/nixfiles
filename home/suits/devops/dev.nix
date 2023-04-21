{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      podman
      podman-compose
      docker-compose
      gnumake
      tree-sitter
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
      ansible-lint
      ansible-language-server
      clippy
      reuse
      graphviz
      nodejs
    ] ++ (with pkgs.nodePackages; [
        typescript-language-server
        bash-language-server
        vscode-json-languageserver
    ]);
  };
}

{ pkgs, ... }:

{
  imports = [
    ./lsp.nix
  ];

  home = {
    packages = with pkgs; [
      curlie
      podman
      podman-compose
      docker-compose
      gnumake
      tree-sitter
      go_1_20
      goreleaser
      sqlite
      protobuf
      jsonnet
      rustc
      cargo
      rustfmt
      ruby
      python3
      typescript
      clippy
      reuse
      graphviz
      gh
      nodejs
      mysql-shell
    ];
  };
}

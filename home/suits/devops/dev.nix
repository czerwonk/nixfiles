{ pkgs-unstable, ... }:

{
  imports = [
    ./lsp.nix
  ];

  home = {
    packages = with pkgs-unstable; [
      podman
      podman-compose
      docker-compose
      gnumake
      tree-sitter
      go_1_21
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

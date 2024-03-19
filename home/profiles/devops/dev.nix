{ pkgs, ... }:

{
  imports = [
    ./lsp.nix
  ];

  home = {
    packages = with pkgs; [
      cargo
      clippy
      dotnet-sdk_8
      gh
      gnumake
      go
      goreleaser
      graphviz
      jsonnet
      mysql-shell
      nodejs
      podman
      podman-compose
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      reuse
      ruby
      rustc
      rustfmt
      sqlite
      tree-sitter
      typescript
    ];
  };
}

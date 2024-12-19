{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cargo
      clippy
      delve
      dotnet-sdk_8
      gh
      gnumake
      go
      goreleaser
      graphviz
      jsonnet
      mysql-shell
      podman
      podman-compose
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      reuse
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
      rustc
      rustfmt
      sqlite
      tree-sitter
      typescript
    ];
  };
}

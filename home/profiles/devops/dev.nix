{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      claude-code
      delve
      gnumake
      go
      goreleaser
      graphviz
      mysql-shell
      podman
      podman-compose
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      reuse
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
      sqlite
      tree-sitter
      typescript
    ];
  };
}

{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      gnumake
      go
      graphviz
      mysql-shell
      podman
      podman-compose
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
      sqlite
    ];
  };
}

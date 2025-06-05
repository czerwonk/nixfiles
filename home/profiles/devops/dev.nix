{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      docker
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
      sqlite
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
    ];
  };
}

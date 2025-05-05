{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      docker
      gnumake
      go
      graphviz
      jujutsu
      mysql-shell
      podman
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      sqlite
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
    ];
  };
}

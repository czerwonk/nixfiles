{ pkgs, ... }:

{
  imports = [
    ./go.nix
    ./python.nix
    ./ruby.nix
    ./rust.nix
  ];

  home = {
    packages = with pkgs; [
      docker
      gcc
      gnumake
      graphviz
      mysql-shell
      podman
      podman-compose
      sqlite
    ];
  };
}

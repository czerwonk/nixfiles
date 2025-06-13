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
      gnumake
      graphviz
      mysql-shell
      podman
      podman-compose
      sqlite
    ];
  };
}

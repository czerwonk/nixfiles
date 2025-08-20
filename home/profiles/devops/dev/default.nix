{ pkgs, ... }:

{
  imports = [
    ./go.nix
    ./python.nix
    ./ruby.nix
    ./rust.nix
    ./typescript.nix
  ];

  home = {
    packages = with pkgs; [
      docker
      gcc
      gnumake
      graphviz
      mysql-shell
      nodejs_24
      podman
      podman-compose
      sqlite
    ];

    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.sqlite.dev}/lib/pkgconfig:${pkgs.mysql80}/lib/pkgconfig";
      MYSQLCLIENT_LIB_DIR = "${pkgs.mysql80}/lib";
      MYSQLCLIENT_VERSION = "8.0";
    };
  };
}

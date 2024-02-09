{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    adoptopenjdk-icedtea-web
  ];
}

{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    adoptopenjdk-icedtea-web
  ];
}

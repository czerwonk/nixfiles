let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  stdenv = pkgs.stdenv;
  jdk = pkgs.openjdk21.override (lib.optionalAttrs stdenv.isLinux {
    enableJavaFX = true;
  });

in pkgs.mkShell {
  packages = [
    jdk
  ];
}

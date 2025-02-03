{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    php
    phpactor
  ];
}

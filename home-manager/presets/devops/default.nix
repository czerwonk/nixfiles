{ pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./ops.nix
  ];
}

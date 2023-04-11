{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./ssh.nix
  ];
}
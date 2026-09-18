{ lib, ... }:

{
  imports = [
    ../common.nix
  ];

  powerManagement.enable = lib.mkForce false;
}

{ lib, ... }:

{
  imports = [
    ../common.nix
    ../../profiles/desktop/cosmic.nix
  ];

  powerManagement.enable = lib.mkForce false;
}

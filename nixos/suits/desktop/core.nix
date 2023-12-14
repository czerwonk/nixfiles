{ lib, ... }:

{
  security.allowUserNamespaces = true;
  nix.settings.sandbox = true;

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
}

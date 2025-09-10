{ pkgs, lib, ... }:

{
  security.allowUserNamespaces = true;
  nix.settings.download-buffer-size = 524288000;

  boot.kernelParams = [ "panic=0" ];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}

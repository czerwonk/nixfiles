{ lib, ... }:

{
  imports = [
    ./sound.nix
    ./wayland.nix
  ];

  security.allowUserNamespaces = true;
  nix.settings.sandbox = true;

  boot.kernelParams = [ "panic=0" ];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}

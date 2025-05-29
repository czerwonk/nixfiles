{ lib, ... }:

{
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.enable = true;

  services.xserver = {
    displayManager.gdm.enable = lib.mkForce false;
    desktopManager.gnome.enable = lib.mkForce false;
  };
}

{ lib, ... }:

{
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.enable = true;

  services.xserver = {
    displayManager.gdm.enable = lib.mkForce false;
    desktopManager.gnome.enable = lib.mkForce false;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}

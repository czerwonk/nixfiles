{ lib, ... }:

{
  services.displayManager = {
    cosmic-greeter.enable = true;
    gdm.enable = lib.mkForce false;
  };

  services.desktopManager = {
    cosmic.enable = true;
    gnome.enable = lib.mkForce false;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}

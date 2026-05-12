{
  services.displayManager = {
    sddm = {
      enable = true;
    };
    gdm = {
      enable = false;
    };
  };

  services.desktopManager = {
    plasma6.enable = true;
    gnome.enable = false;
  };
}

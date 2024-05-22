{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.xserver = {
    displayManager = {
      gdm = {
        enable = false;
      };
    };
    desktopManager.gnome = {
      enable = false;
    };
  };

  services.desktopManager.plasma6.enable = true;
}

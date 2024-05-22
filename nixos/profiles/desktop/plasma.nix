{
  services.xserver = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
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

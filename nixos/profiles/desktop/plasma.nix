{
  services.xserver = {
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      gdm = {
        enable = false;
      };
    };
  };

  services.desktopManager.plasma6.enable = true;
}

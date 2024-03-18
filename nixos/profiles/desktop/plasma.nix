{
  services.xserver = {
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  services.desktopManager.plasma6.enable = true;
}

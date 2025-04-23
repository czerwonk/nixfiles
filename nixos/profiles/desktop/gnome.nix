{ pkgs, lib, ... }:

{
  services.xserver = {
    displayManager.gdm = {
      enable = lib.mkDefault true;
      wayland = lib.mkDefault true;
    };
    desktopManager.gnome = {
      enable = lib.mkDefault true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
  };

  services.gnome = {
    games.enable = false;
    core-developer-tools.enable = false;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      gnome-connections
      gnome-maps
      gnome-music
      gnome-photos
      gnome-text-editor
      gnome-tour
      seahorse # keyring UI
    ]
  );

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection
    gnomeExtensions.pop-shell
    pop-launcher
  ];
}

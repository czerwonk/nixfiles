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
    core-developer-tools.enable = false;
    games.enable = false;
    gnome-initial-setup.enable = false;
    gnome-remote-desktop.enable = false;
    gnome.rygel.enable = false;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gnome-backgrounds
      gnome-console
      gnome-connections
      gnome-maps
      gnome-music
      gnome-photos
      gnome-text-editor
      gnome-tour
      gnome-weather
      seahorse # keyring UI
    ]
  );

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection
    gnomeExtensions.pop-shell
    papers
    pop-launcher
  ];
}

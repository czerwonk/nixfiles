{ pkgs, lib, ... }:

{
  imports = [
    ../common.nix
  ];

  services = {
    desktopManager.gnome = {
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']

        # Disable automatic suspend on AC power
        [org.gnome.settings-daemon.plugins.power]
        sleep-inactive-ac-type='nothing'
        sleep-inactive-battery-type='nothing'
        sleep-inactive-ac-timeout=0
        sleep-inactive-battery-timeout=0

        # Disable screen blanking/idle
        [org.gnome.desktop.session]
        idle-delay=uint32 0

        # Disable screensaver
        [org.gnome.desktop.screensaver]
        lock-enabled=false
        lock-delay=uint32 0
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

  powerManagement.enable = lib.mkForce false;
}

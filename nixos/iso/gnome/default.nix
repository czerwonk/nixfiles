{ pkgs, lib, ... }:

{
  imports = [
    ../common.nix
  ];

  services.xserver = {
    desktopManager.gnome = {
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

  environment.gnome.excludePackages = (with pkgs; [
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
  ]);

  powerManagement.enable = lib.mkForce false;
}

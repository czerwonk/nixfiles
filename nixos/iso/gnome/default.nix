{ pkgs, lib, ... }:

{
  imports = [
    ../common.nix
  ];

  services.xserver = {
    desktopManager.gnome = {
      extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
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
    gnome-photos
    gnome-tour
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-maps
    epiphany # web browser
    geary # email reader
    seahorse # keyring UI
  ]);

  powerManagement.enable = lib.mkForce false;
}

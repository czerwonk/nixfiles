{ pkgs, lib, ... }:

{
  services.xserver = {
    displayManager.gdm = {
      enable = lib.mkDefault true;
      wayland = lib.mkDefault true;
    };
    desktopManager.gnome = {
      enable = lib.mkDefault true;
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

  environment.systemPackages = with pkgs; [
    gnomeExtensions.pop-shell
  ];
}

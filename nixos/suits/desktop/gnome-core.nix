{ pkgs, lib, username, ... }:

{
  security.allowUserNamespaces = true;
  nix.settings.sandbox = true;

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome = {
      enable = true;
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

  users.users.${username} = {
    packages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-maps
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    seahorse # keyring UI
  ]);
}

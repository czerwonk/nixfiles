{ pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  boot.supportedFilesystems = [ "bcachefs" ];

  services.xserver = {
    desktopManager.gnome = {
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
    gedit # text editor
    epiphany # web browser
    geary # email reader
    seahorse # keyring UI
  ]);
}

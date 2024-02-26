{ pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

	nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

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
    epiphany # web browser
    geary # email reader
    seahorse # keyring UI
  ]);
}

{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./dunst.nix
    ./rofi
    ./swaylock.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };
}

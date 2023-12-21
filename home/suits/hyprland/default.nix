{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./theme.nix
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
}

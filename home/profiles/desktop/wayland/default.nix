{ pkgs, ... }:

{
  imports = [
    ../gnome
    ./rofi
    ./options.nix
    ./waybar.nix
    ./dunst.nix
    ./swaylock.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    networkmanagerapplet
  ];
}

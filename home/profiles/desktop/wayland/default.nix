{ pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./options.nix
    ./rofi
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    networkmanagerapplet
  ];
}

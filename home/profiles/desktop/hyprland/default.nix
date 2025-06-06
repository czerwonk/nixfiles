{ pkgs, ... }:

let
  screenshot-script = pkgs.writeScriptBin "hypr-screenshot" ''
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -
  '';
  close-all-script = pkgs.writeScriptBin "hypr-close-all" ''
    HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
    hyprctl --batch "$HYPRCMDS"
  '';
  halt-script = pkgs.writeScriptBin "hypr-halt" ''
    ${close-all-script}/bin/hypr-close-all
    sleep 3
    shutdown now
  '';
  reboot-script = pkgs.writeScriptBin "hypr-reboot" ''
    ${close-all-script}/bin/hypr-close-all
    sleep 3
    shutdown -r now
  '';
  logout-script = pkgs.writeScriptBin "hypr-logout" ''
    ${close-all-script}/bin/hypr-close-all
    sleep 3
    hyprctl dispatch exit
  '';

in
{
  imports = [
    ../gnome
    ../rofi
    ./options.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./dunst.nix
    ./swaylock.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    halt-script
    logout-script
    nerd-fonts.jetbrains-mono
    networkmanagerapplet
    reboot-script
    screenshot-script
  ];
}

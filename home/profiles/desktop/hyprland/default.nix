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

in {
  imports = [
    ./../gnome
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
    halt-script
    reboot-script
    logout-script
    screenshot-script
  ];
}

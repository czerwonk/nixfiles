{ username, config, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = /home/${username}/.config/bg.jpg
    wallpaper = eDP-1,/home/${username}/.config/bg.jpg
    wallpaper = ${config.suits.hyprland.externalMonitor},/home/${username}/.config/bg.jpg
  '';
}

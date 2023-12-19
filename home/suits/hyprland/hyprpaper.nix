{ username, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = /home/${username}/.config/bg.jpg
    wallpaper = eDP-1,/home/${username}/.config/bg.jpg
    wallpaper = HDMI-A-1,/home/${username}/.config/bg.jpg
  '';
}

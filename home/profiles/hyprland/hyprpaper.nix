{ username, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = /home/${username}/.config/bg.jpg
    wallpaper = ,/home/${username}/.config/bg.jpg
  '';
}

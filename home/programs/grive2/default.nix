{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      grive2
      inotify-tools
    ];
  };
}

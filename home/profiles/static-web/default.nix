{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      hugo
      dart-sass
    ];
  };
}

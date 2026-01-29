{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gphoto2
      rawtherapee
      exiftool
    ];
  };
}

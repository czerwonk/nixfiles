{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gphoto2
      darktable
      exiftool
    ];
  };
}

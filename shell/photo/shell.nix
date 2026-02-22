{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gphoto2
    exiftool
  ];
}

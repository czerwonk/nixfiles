{ pkgs, ... }:

{
  imports = [
    ../../devices/davinci-speed-editor.nix
    ../../devices/tour-box.nix
  ];

  environment.systemPackages = with pkgs; [
    davinci-resolve-studio
    digikam
    exiftool
    ffmpeg
    libraw
  ];
}

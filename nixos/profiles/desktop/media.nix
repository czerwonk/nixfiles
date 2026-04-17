{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    davinci-resolve-studio
    digikam
    exiftool
    ffmpeg
    libraw
  ];
}

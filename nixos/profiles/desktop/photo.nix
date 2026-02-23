{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    digikam
    exiftool # Critical for CR3/DNG metadata
    ffmpeg # For video frame extraction
    libraw # The engine for RAW files
  ];
}

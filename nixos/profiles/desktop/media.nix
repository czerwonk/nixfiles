{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    davinci-resolve-studio
    digikam
    exiftool
    ffmpeg
    libraw
  ];

  users.groups.plugdev = { };
  users.users.${username}.extraGroups = [ "plugdev" ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1edb", MODE="0666", GROUP="plugdev"
  '';
}

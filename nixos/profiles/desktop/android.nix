{ pkgs, username, ... }:

{
  programs.adb.enable = true;
  users.users.${username}.extraGroups = ["adbusers"];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  environment.systemPackages = [ pkgs.android-studio ];
}

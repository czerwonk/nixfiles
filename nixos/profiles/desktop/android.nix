{ pkgs, username, ... }:

{
  programs.adb.enable = true;
  users.users.${username}.extraGroups = ["adbusers"];

  environment.systemPackages = [ pkgs.android-studio ];
}

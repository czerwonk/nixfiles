{ pkgs, username, ... }:

{
  users.users.${username}.extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];
}

{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.all-ways-egpu
  ];
}

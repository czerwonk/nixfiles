{ config, lib, pkgs, ... }:

let
  inherit (config.boot.kernelPackages) virtualboxGuestAdditions;

  path = lib.strings.makeBinPath [
    pkgs.gnugrep
    pkgs.xorg.xorgserver.out
    pkgs.which
  ];

in

{
  config.services.xserver.displayManager.sessionCommands = ''
    PATH=${path}:$PATH  ${lib.meta.getExe' virtualboxGuestAdditions "VBoxClient"} --vmsvga
  '';
}

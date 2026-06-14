{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tuxbox
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2dd3", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="hidraw", KERNEL=="hidraw*", ATTRS{idVendor}=="2dd3", MODE="0666"
  '';
}

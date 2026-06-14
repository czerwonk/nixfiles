{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1edb", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="hidraw", KERNEL=="hidraw*", ATTRS{idVendor}=="1edb", MODE="0666"
  '';
}

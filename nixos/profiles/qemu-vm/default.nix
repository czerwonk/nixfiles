{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.kernelModules = [
    "uinput"
  ];

  services.spice-vdagentd.enable = true;

  services.qemuGuest.enable = true;

  services.xserver.videoDrivers = [ "qxl" ];
}

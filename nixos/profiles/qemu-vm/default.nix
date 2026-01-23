{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.kernelModules = [ "uinput" ];
  boot.initrd.kernelModules = [ "virtio_gpu" ];

  services.spice-vdagentd.enable = true;

  services.qemuGuest.enable = true;

  hardware.graphics.enable = true;
}

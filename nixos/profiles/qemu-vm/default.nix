{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.kernelModules = [
    "uinput"
    "virtio_gpu"
  ];
  boot.initrd.kernelModules = [ "virtio_gpu" ];

  services.spice-vdagentd.enable = true;

  services.qemuGuest.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # If needed for 32-bit apps
  };
}

{ modulesPath, inputs, ... }:

{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix")
    "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
  ];

  boot.kernelModules = [
    "uinput"
  ];

  virtualisation.qemu.options = [
    "-vga qxl -device virtio-serial-pci -spice port=5930,disable-ticketing=on -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent"
  ];

  services.spice-vdagentd.enable = true;

  virtualisation.qemu.guestAgent.enable = true;
}

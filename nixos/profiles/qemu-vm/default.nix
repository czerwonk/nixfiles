{ modulesPath, inputs, ... }:

{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix")
    "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
  ];

  boot.kernelModules = [
    "uinput"
  ];

  services.spice-vdagentd.enable = true;

  #virtualisation.qemu.guestAgent.enable = true;
}

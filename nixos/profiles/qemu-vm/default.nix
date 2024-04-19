{ modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.kernelModules = [
    "uinput"
  ];

  services.spice-vdagentd.enable = true;

  virtualisation.qemu.guestAgent.enable = true;
}

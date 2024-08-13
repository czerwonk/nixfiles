{ pkgs, lib, config, ... }:

with lib;

{
  options = {
    use_egpu = mkOption {
      type = types.bool;
      default = true;
      description = "Wether to use e-GPU";
    };
  };

  config = mkIf config.use_egpu {
    boot.kernelParams = [
      "amdgpu.pcie_gen_cap=0x40000" # Force AMD GPU to use full width (optional)
    ];

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    hardware.opengl.extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];

    environment.systemPackages = [
      pkgs.all-ways-egpu
    ];

    my.services.ai.acceleration = "rocm";

    systemd.services.all-ways-egpu = {
      enable = true;
      description = "Configure eGPU as primary under Wayland desktops";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe pkgs.all-ways-egpu} set-boot-vga egpu";
      };
      before = [ "display-manager.service" ];
      wantedBy = [ "graphical.target" ];
      path = with pkgs; [
        gawk
        mount
        pciutils
        umount
      ];
    };
  };
}

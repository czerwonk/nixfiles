{ pkgs, lib, config, username, ... }:

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
    users.users.${username}.extraGroups = [ "render" ];

    boot.kernelParams = [
      "amdgpu.pcie_gen_cap=0x40000" # Force AMD GPU to use full width (optional)
    ];

    systemd.tmpfiles.rules = 
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    environment.systemPackages = with pkgs; [
      all-ways-egpu
      nvtopPackages.full
      rocmPackages.rocminfo
    ];

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

    services.ollama = {
      enable = true;
      acceleration = "rocm";
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "11.0.0";
    };

    systemd.services.ollama.wantedBy = lib.mkForce [];
  };
}

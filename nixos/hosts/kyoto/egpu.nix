{ pkgs, lib, username, ... }:

{
  users.users.${username}.extraGroups = [ "render" "video" ];

  hardware = {
    amdgpu = {
      opencl.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.rocm-runtime
        amdvlk
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    rocmPackages.hipcc
    rocmPackages.rocm-runtime
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
    user = "ollama";
    group = "ollama";
    acceleration = "rocm";
    package = pkgs.ollama-rocm;
  };

  systemd.services.ollama.wantedBy = lib.mkForce [];
}

{ pkgs, ... }:

{
  kernelParams = [
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
}

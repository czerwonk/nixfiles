{ pkgs, ... }:

{
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

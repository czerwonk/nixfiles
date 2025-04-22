{ pkgs, username, ... }:

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
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    rocmPackages.hipcc
    rocmPackages.rocm-runtime
  ];
}

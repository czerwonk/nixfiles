{ pkgs, lib, username, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = lib.mkDefault "ignore";
    qemu = {
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = false;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  programs.virt-manager.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];
}

{ pkgs, lib, username, ... }:

{
  environment.systemPackages = [ pkgs.swtpm ];

  virtualisation.libvirtd = {
    enable = true;
    onBoot = lib.mkDefault "ignore";
    qemu = {
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMFFull.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
    sshProxy = false;
  };

  programs.virt-manager.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];
}

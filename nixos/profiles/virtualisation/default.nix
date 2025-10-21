{
  pkgs,
  lib,
  username,
  ...
}:

{
  environment.systemPackages = [ pkgs.swtpm ];

  virtualisation.libvirtd = {
    enable = true;
    onBoot = lib.mkDefault "ignore";
    qemu = {
      swtpm.enable = true;
    };
    sshProxy = false;
  };

  programs.virt-manager.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];
}

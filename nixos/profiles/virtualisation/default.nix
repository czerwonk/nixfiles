{
  pkgs,
  lib,
  username,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    lima
    swtpm
    virt-viewer
  ];

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

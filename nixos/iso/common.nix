{
  imports = [
    ../common.nix
    ../zfs/desktop.nix
  ];

  boot.zfs.forceImportRoot = false;
  services.sanoid.enable = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  security.auditd.enable = false;
  security.allowUserNamespaces = true;

  my.services.openssh-server = {
    enable = true;
    openFirewall = true;
  };
}

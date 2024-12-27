{
  imports = [
    ../common.nix
    ../zfs
  ];

  boot.zfs.forceImportRoot = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  my.services.openssh-server = {
    enable = true;
    openFirewall = true;
  };
}

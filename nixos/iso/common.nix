{
  imports = [
    ../common.nix
    ../zfs
  ];

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  my.services.openssh-server = {
    enable = true;
    openFirewall = true;
  };
}

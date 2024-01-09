{ pkgs, ... }:

{
  imports = [
    ./iptables.nix
    ./nftables.nix
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  virtualisation.containers.containersConf.settings = {
    network.firewall_driver = "none";
  };

  environment.systemPackages = with pkgs; [
    arion
  ];

  virtualisation.oci-containers.backend = "podman";
}

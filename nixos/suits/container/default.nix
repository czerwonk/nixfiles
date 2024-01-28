{ config, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  virtualisation.oci-containers.backend = "podman";
  
  networking.firewall.trustedInterfaces = [
    (if config.networking.nftables.enable then "podman*" else "podman+")
  ];

  # virtualisation.containers.containersConf.settings = {
  #   network.firewall_driver = "none";
  # };
  #
  # networking.proxy.envVars = {
  #   NETAVARK_FW = "none";
  # };
}

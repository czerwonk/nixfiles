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
    "podman*"
  ];
}

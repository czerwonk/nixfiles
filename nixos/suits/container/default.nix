{ pkgs, ... }:

{
  security.allowUserNamespaces = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = with pkgs; [
        gvisor
      ];
    };
  };

  virtualisation.oci-containers.backend = "podman";
  
  networking.firewall.trustedInterfaces = [
    "podman*"
  ];
}

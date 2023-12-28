{ pkgs, ... }:

{
  networking.firewall.trustedInterfaces = [ "podman+" ];

  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-client
    arion
  ];
}

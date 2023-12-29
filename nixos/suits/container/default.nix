{ pkgs, pkgs-unstable, ... }:

{
  networking.firewall.trustedInterfaces = [ "podman+" ];

  nixpkgs.overlays = [
    (self: super: {
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
    })
  ];

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

  virtualisation.oci-containers.backend = "podman";
}

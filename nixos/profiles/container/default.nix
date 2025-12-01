{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.profiles.container;

in
{
  config = {
    security.allowUserNamespaces = true;

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = false;
        defaultNetwork.settings.dns_enabled = true;
        extraPackages = with pkgs; [
          gvisor
        ];
      };
    };

    virtualisation.oci-containers.backend = "podman";

    networking.firewall.trustedInterfaces = [ "podman*" ];

    environment.sessionVariables = {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };
  };
}

{
  pkgs,
  lib,
  ...
}:

{
  security.allowUserNamespaces = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = lib.mkDefault true;
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
}

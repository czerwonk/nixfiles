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
  options = {
    profiles.container.disableFirewall = lib.mkEnableOption "Wether to create firewall rules";
  };

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

    virtualisation.containers.containersConf.settings = lib.mkIf cfg.disableFirewall {
      network.firewall_driver = lib.mkForce "none";
    };

    networking.proxy.envVars = lib.mkIf cfg.disableFirewall {
      NETAVARK_FW = "none";
    };

    environment.sessionVariables = {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };
  };
}

{ pkgs, lib, config, ... }:

let
  cfg = config.profiles.container;

in {
  options = {
    profiles.container.disableFirewall = lib.mkEnableOption "Wether to create firewall rules";
  };

  config = {
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

    networking.firewall.trustedInterfaces = [ "podman*" ];

    virtualisation.containers.containersConf.settings = lib.mkIf cfg.disableFirewall {
      network.firewall_driver = "none";
    };

    networking.proxy.envVars = lib.mkIf cfg.disableFirewall {
      NETAVARK_FW = "none";
    };
  };
}

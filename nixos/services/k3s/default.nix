{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.k3s;

in {
  options = {
    my.services.k3s.enable = mkEnableOption "Jellyfin Media System";
  };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
    };

    environment.systemPackages = [ pkgs.k3s ];

    environment.persistence."/persist" = {
      directories = [
        "/etc/rancher"
      ];
    };

    networking.firewall.trustedInterfaces = [ "cni*" ];
  };
}

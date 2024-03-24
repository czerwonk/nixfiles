{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.k3s;

in {
  options = {
    my.services.k3s = {
      enable = mkEnableOption "Jellyfin Media System";

      autoStart = mkOption {
        type = types.bool;
        default = true;
      };
    };
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

    systemd.services.k3s.wantedBy = mkIf (!cfg.autoStart) (lib.mkForce []);
  };
}

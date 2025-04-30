{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.k3s;

in
{
  options = {
    my.services.k3s = {
      enable = mkEnableOption "k3s Kubernetes service";

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

    networking.firewall.trustedInterfaces = [ "cni*" ];

    systemd.services.k3s.wantedBy = mkIf (!cfg.autoStart) (lib.mkForce [ ]);
  };
}

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
      extraFlags = [
        "--disable=traefik,servicelb"
        "--flannel-backend=host-gw"
        "--bind-address=192.168.100.2"
        "--node-ip=192.168.100.2"
      ];
    };

    systemd.services.k3s-netns = {
      description = "K3s Network Namespace";
      before = [ "k3s.service" ];
      path = with pkgs; [
        iproute2
        coreutils
      ];
      wantedBy = mkIf (!cfg.autoStart) (lib.mkForce [ ]);
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = pkgs.writeShellScript "setup-k3s-netns" ''
          set -euo pipefail

          # Create namespace
          ${pkgs.iproute2}/bin/ip netns add k3s-ns || true

          # Create veth pair
          ${pkgs.iproute2}/bin/ip link add k3s-host type veth peer name k3s-guest || true

          # Move guest end to namespace
          ${pkgs.iproute2}/bin/ip link set k3s-guest netns k3s-ns

          # Configure host side
          ${pkgs.iproute2}/bin/ip addr add 192.168.100.1/24 dev k3s-host || true
          ${pkgs.iproute2}/bin/ip link set k3s-host up

          # Configure guest side
          ${pkgs.iproute2}/bin/ip netns exec k3s-ns ip addr add 192.168.100.2/24 dev k3s-guest
          ${pkgs.iproute2}/bin/ip netns exec k3s-ns ip link set k3s-guest up
          ${pkgs.iproute2}/bin/ip netns exec k3s-ns ip link set lo up
          ${pkgs.iproute2}/bin/ip netns exec k3s-ns ip route add default via 192.168.100.1

          # Route to pod network (flannel creates this in the namespace)
          ${pkgs.iproute2}/bin/ip route add 10.42.0.0/16 via 192.168.100.2 dev k3s-host || true

          # Route to service network (kube-proxy creates this in the namespace)
          ${pkgs.iproute2}/bin/ip route add 10.43.0.0/16 via 192.168.100.2 dev k3s-host || true
        '';
        ExecStop = pkgs.writeShellScript "cleanup-k3s-netns" ''
          ${pkgs.iproute2}/bin/ip link del k3s-host || true
          ${pkgs.iproute2}/bin/ip netns del k3s-ns || true
        '';
      };
    };

    environment.systemPackages = with pkgs; [
      k3s
    ];

    networking.firewall.trustedInterfaces = [ "k3s-host" ];

    networking.nat.internalInterfaces = [ "k3s-host" ];

    systemd.services.k3s = {
      after = [ "k3s-netns.service" ];
      requires = [ "k3s-netns.service" ];
      serviceConfig = {
        NetworkNamespacePath = "/var/run/netns/k3s-ns";
        AmbientCapabilities = [
          "CAP_NET_ADMIN"
          "CAP_SYS_ADMIN"
        ];
      };
    };
  };
}

{
  pkgs,
  ...
}:

{
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

  systemd.services.netavark-fixup = {
    description = "Remove unscoped ct state invalid drop from netavark FORWARD chain";
    after = [ "podman.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [
      pkgs.nftables
      pkgs.gawk
    ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 5;
      ExecStart = pkgs.writeShellScript "netavark-fixup" ''
        while true; do
          handle=$(nft -a list chain inet netavark FORWARD 2>/dev/null \
            | grep 'ct state invalid drop' \
            | awk '{print $NF}')
          if [ -n "$handle" ]; then
            nft delete rule inet netavark FORWARD handle "$handle" && \
              echo "Removed ct state invalid drop (handle $handle)"
          fi
          sleep 5
        done
      '';
    };
  };
}

{ ... }:

{
  networking.firewall.extraCommands = ''
    iptables -A INPUT -i podman+ -p udp --dport 53 -j ACCEPT
  '';
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}

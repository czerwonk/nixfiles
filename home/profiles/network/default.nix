{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bgpq4
      dogdns
      host
      ipcalc
      iperf
      iperf3
      mtr
      nmap
      tcpdump
      tcptraceroute
    ];
  };
}

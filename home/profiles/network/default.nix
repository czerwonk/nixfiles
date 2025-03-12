{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bgpq4
      dig
      dogdns
      ethr
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

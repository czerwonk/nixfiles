{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      dig
      host
      bgpq4
      tcptraceroute
      iperf
      iperf3
      nmap
      ipcalc
      tcpdump
    ];
  };

}

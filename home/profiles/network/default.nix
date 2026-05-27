{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bgpq4
      host
      dogedns
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

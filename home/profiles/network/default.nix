{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bgpq4
      dig
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

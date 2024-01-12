{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      dig
      host
      mtr
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

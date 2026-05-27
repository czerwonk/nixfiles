{ pkgs, lib, ... }:

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
    shellAliases = {
      dig = lib.getExe pkgs.dogedns;
    };
  };
}
